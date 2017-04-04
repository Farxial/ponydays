var dateFormat = require('dateformat');
import render_comment from "./Comment.component"
import $ from "jquery"
import * as Comments from './comments'
import Emitter from "./emitter"

export default class Tree {
  
  obj = $("#comments-tree")[0]

  state = {
    sorted_ids: [],
    comments: [],
    max_nesting: parseInt (($("#comments").width()-250)/20)
  }

  calcNesting() {
    this.setState({
      max_nesting: parseInt(($("#comments").width()-250)/20)
    })
  }

  renderNewComments(new_comments){
    console.log("start render")
    function sortByTree(a,b) {
      let a_index = this.state.sorted_ids.indexOf(a)
      let b_index = this.state.sorted_ids.indexOf(b)
      if (a_index < b_index) {
        return -1
      } else {
        return 1
      }
    }
    let new_comments_ids = Object.keys(new_comments)
    console.log(new_comments)
    new_comments_ids.sort(sortByTree.bind(this))
    for (let key in new_comments_ids) {
      let cmt = new_comments[new_comments_ids[key]]
      if ($(`[data-id=${cmt.id}]`).length == 0) {
        let cmt_html = render_comment(cmt, this.state.max_nesting)
        console.log("Inserting comment", cmt, this.state.sorted_ids[this.state.sorted_ids.indexOf(cmt.id)-1]) 
        if ($(`[data-id=${this.state.sorted_ids[this.state.sorted_ids.indexOf(cmt.id)-1]}]`).length != 1) {
          console.info("No parent comment in DOM!", cmt, this.state.sorted_ids)
          $(this.obj).append($(cmt_html))
        }
        $(cmt_html).insertAfter(`[data-id=${this.state.sorted_ids[this.state.sorted_ids.indexOf(cmt.id)-1]}]`)
        if ($(`[data-id=${cmt.id}]`).length != 1) {
          console.error("No inserted comment in DOM!", cmt, this.state.sorted_ids)
        }
      }
    }
    console.log("finished render")
  }

  mount(obj, comments, ids) {
    this.obj = obj
    $(window).on('resize', this.calcNesting.bind(this))

    let sorted_ids = this.sortTree(ids, comments)

    this.state.sorted_ids =  sorted_ids
    this.state.comments =  comments

    this.render(this.obj)

    Emitter.on("comments-new-loaded", function(new_comments){
        console.log("New comments catched", dateFormat(new Date(), "HH:MM:ss:l"))
      let new_sorted_ids = this.state.sorted_ids
      let comments = this.state.comments

      for (let key in new_comments) {
        let cmt = new_comments[key]
        if (cmt.parentId) {
          let parent = comments[cmt.parentId]
          cmt.level = parseInt(parent.level) + 1
        } else {
          cmt.level = 0
        }
        //console.log(key, cmt)
        comments[cmt.id] = cmt
        new_sorted_ids.push(cmt.id)
      }
      new_sorted_ids = this.sortTree(new_sorted_ids, comments)
      this.state.comments = comments
      this.state.sorted_ids = new_sorted_ids
      console.log("Before insert", dateFormat(new Date(), "HH:MM:ss:l"))
      this.renderNewComments(new_comments)
      console.log("After insert", dateFormat(new Date(), "HH:MM:ss:l"))
    }.bind(this))
    
    function goToPrevComment(){
      Comments.scrollToComment($('.comment-current').prev().data('id'))
    }
    function goToNextComment(){
      Comments.scrollToComment($('.comment-current').next().data('id'))
    }
    
    function goToLastComment(){
      Comments.scrollToComment(this.state.sorted_ids[this.state.sorted_ids.length-1])
    }
    
    function goToFirstComment(){
      Comments.scrollToComment(this.state.sorted_ids[0])
    }
    
    function goToNextBranch(){
      let cur_id = $('.comment-current').data("id")
      let cur_cmt = this.state.comments[cur_id]
      let data = this.state.sorted_ids.slice(this.state.sorted_ids.indexOf(""+cur_id)+1)
      let prev_branch = this.state.sorted_ids[0]
      console.log(cur_id,this.state.sorted_ids.indexOf(cur_id),data)
      for (let key in data) {
        let id = data[key]
        let cmt = this.state.comments[id]
        console.log(cmt)
        if (cmt.level == 0) {
          prev_branch = cmt.id
          console.log(cmt.id)
          break
        }
      }
      Comments.scrollToComment(prev_branch)
    }
    
    function goToPrevBranch(){
      let cur_id = $('.comment-current').data("id")
      let cur_cmt = this.state.comments[cur_id]
      let data = this.state.sorted_ids.slice(0, this.state.sorted_ids.indexOf(""+cur_id)).reverse()
      let prev_branch = this.state.sorted_ids[0]
      console.log(cur_id,this.state.sorted_ids.indexOf(cur_id),data)
      for (let key in data) {
        let id = data[key]
        let cmt = this.state.comments[id]
        console.log(cmt)
        if (cmt.level == 0) {
          prev_branch = cmt.id
          console.log(cmt.id)
          break
        }
      }
      Comments.scrollToComment(prev_branch)
    }
    
    function toggleReplyOnCurrent(){
      Comments.toggleCommentForm($('.comment-current').data("id"))
    }
    
    function updateComments(){
      Comments.load(window.targetId, window.targetType)
    }
    
    function updateCommentsSoft(){
      Comments.load(window.targetId, window.targetType)
    }
    
    $(document).on('keydown', null, 'ctrl+space', Comments.goToNextComment);
    $(document).on('keydown', null, 'ctrl+up', goToPrevComment)
    $(document).on('keydown', null, 'ctrl+down', goToNextComment)
    $(document).on('keydown', null, 'ctrl+end', goToLastComment.bind(this))
    $(document).on('keydown', null, 'ctrl+home', goToFirstComment.bind(this))
    $(document).on('keydown', null, 'alt+pagedown', goToNextBranch.bind(this))
    $(document).on('keydown', null, 'alt+pageup', goToPrevBranch.bind(this))
    $(document).on('keydown', null, 'alt+r', toggleReplyOnCurrent.bind(this))
    $(document).on('keydown', null, 'alt+u', updateComments)
    $(document).on('keydown', null, 'alt+shift+u', updateCommentsSoft)
  }


  sortTree(r_ids, comments) {
    let ids = []
    for (let i in r_ids) {
      if (ids.indexOf(r_ids[i])>=0) {
        continue
      }
      ids.push(r_ids[i])
    }
    let sorted_ids = []
    for (let i in ids) {
      if (!comments[ids[i]].parentId) {
        sorted_ids.push(ids[i])
      }
    }

    for (let i=0; i<sorted_ids.length; i++) {
      let id = sorted_ids[i]

      let data = ids.slice(ids.indexOf(id)+1).reverse()
      for (let y in data) {
        if (comments[data[y]].parentId == id) {
          sorted_ids.splice(i+1, 0, data[y])
        }
      }
    }
    window.ids = sorted_ids
    return sorted_ids
  }

  render(obj) {
    this.obj.innerHTML = `<div>${this.state.sorted_ids.map(function(id){
      return render_comment(this.state.comments[id], this.state.max_nesting)
    }.bind(this)).join("")}</div>`
  }
}

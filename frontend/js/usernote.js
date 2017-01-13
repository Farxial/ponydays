import $ from 'jquery'

export let sText = '';

export function showForm(sText) {
    $('#usernote-button-add').hide();
    $('#usernote-note').hide();
    $('#usernote-form').show();
    if (this.sText) {
        $('#usernote-form-text').html(this.sText);
    } else {
        $('#usernote-form-text').val('');
    }
    $('#usernote-form-text').focus();
    return false;
};

export function hideForm() {
    $('#usernote-form').hide();
    if (this.sText) {
        this.showNote();
    } else {
        $('#usernote-button-add').show();
    }
    return false;
};

export function save(iUserId) {
    var url = aRouter['profile'] + 'ajax-note-save/';
    var params = {iUserId: iUserId, text: $('#usernote-form-text').val()};
    ls.hook.marker('saveBefore');
    ls.ajax(url, params, function (result) {
        if (result.bStateError) {
            ls.msg.error(null, result.sMsg);
        } else {
            this.sText = result.sText;
            this.showNote();
            ls.hook.run('ls_usernote_save_after', [params, result]);
        }
    }.bind(this));
    return false;
};

export function showNote() {
    $('#usernote-form').hide();
    $('#usernote-note').show();
    $('#usernote-note-text').html(this.sText);
};

export function remove(iUserId) {
    var url = aRouter['profile'] + 'ajax-note-remove/';
    var params = {iUserId: iUserId};
    ls.hook.marker('removeBefore');
    ls.ajax(url, params, function (result) {
        if (result.bStateError) {
            ls.msg.error(null, result.sMsg);
        } else {
            $('#usernote-note').hide();
            $('#usernote-button-add').show();
            this.sText = '';
            ls.hook.run('ls_usernote_remove_after', [params, result]);
        }
    }.bind(this));
    return false;
};

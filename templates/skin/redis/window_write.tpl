<div class="modal modal-write" id="modal_write">
	<header class="modal-header">
		<h3>{$aLang.block_create}</h3>
		<a href="#" class="close jqmClose material-icons">close</a>
	</header>

	{strip}
	<div class="modal-content">
		<ul class="write-list">
			<li class="write-item-type-topic">
				<a href="{router page='topic'}add" class="write-item-icon write-item-image"><i class="fa fa-file-text-o"></i></a>
				<a href="{router page='topic'}add" class="write-item-link">{$aLang.block_create_topic_topic}</a>
			</li>
			<li class="write-item-type-poll">
				<a href="{router page='question'}add" class="write-item-icon write-item-image"><i class="fa fa-align-left"></i></a>
				<a href="{router page='question'}add" class="write-item-link">{$aLang.block_create_topic_question}</a>
			</li>
			<li class="write-item-type-link">
				<a href="{router page='link'}add" class="write-item-icon write-item-image"><i class="fa fa-link"></i></a>
				<a href="{router page='link'}add" class="write-item-link">{$aLang.block_create_topic_link}</a>
			</li>
			<li class="write-item-type-blog">
				<a href="{router page='blog'}add" class="write-item-icon write-item-image"><i class="fa fa-folder-o"></i></a>
				<a href="{router page='blog'}add" class="write-item-link">{$aLang.block_create_blog}</a>
			</li>
			<li class="write-item-type-draft">
				<a href="{router page='topic'}saved/" class="write-item-icon write-item-image"><i class="fa fa-pencil"></i></a>
				<a href="{router page='topic'}saved/" class="write-item-link">{$aLang.topic_menu_saved} {if $iUserCurrentCountTopicDraft}({$iUserCurrentCountTopicDraft}){/if}</a>
			</li>
			{hook run='write_item' isPopup=true}
		</ul>
	</div>
	{/strip}
</div>

<table class="table table-users">
	{if $bUsersUseOrder}
		<thead>
			<tr>
				<th class="cell-name"><a href="{$sUsersRootPage}?order=user_login&order_way={if $sUsersOrder=='user_login'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_login'}class="{$sUsersOrderWay}"{/if}>{$aLang.user}</a></th>
				{if $oUserCurrent}{if $oUserCurrent->isAdministrator() || $oUserCurrent->isGlobalModerator()}<th class="cell-email">Email</th>{/if}{/if}
				<th>{$aLang.user_date_last}</th>
				<th><a href="{$sUsersRootPage}?order=user_date_register&order_way={if $sUsersOrder=='user_date_register'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_date_register'}class="{$sUsersOrderWay}"{/if}>{$aLang.user_date_registration}</a></th>
				<th class="cell-skill"><a href="{$sUsersRootPage}?order=user_skill&order_way={if $sUsersOrder=='user_skill'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_skill'}class="{$sUsersOrderWay}"{/if}>{$aLang.user_skill}</a></th>
				<th class="cell-rating"><a href="{$sUsersRootPage}?order=user_rating&order_way={if $sUsersOrder=='user_rating'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_rating'}class="{$sUsersOrderWay}"{/if}>{$aLang.user_rating}</a></th>
			</tr>
		</thead>
	{else}
		<thead>
			<tr>
				<th class="cell-name">{$aLang.user}</th>
				{if $oUserCurrent}{if $oUserCurrent->isAdministrator() || $oUserCurrent->isGlobalModerator()}<th class="cell-email">Email</th>{/if}{/if}
				<th class="cell-date">{$aLang.user_date_last}</th>
				<th class="cell-date">{$aLang.user_date_registration}</th>
				<th class="cell-skill">{$aLang.user_skill}</th>
				<th class="cell-rating">{$aLang.user_rating}</th>
			</tr>
		</thead>
	{/if}

	<tbody>
		{if $aUsersList}
			{foreach from=$aUsersList item=oUserList}
				{assign var="oSession" value=$oUserList->getSession()}
				{assign var="oUserNote" value=$oUserList->getUserNote()}
				<tr>
					<td class="cell-name">
						<a href="{$oUserList->getUserWebPath()}"><img src="{$oUserList->getProfileAvatarPath(24)}" alt="avatar" class="avatar" /></a>
						<p class="username word-wrap"><a href="{$oUserList->getUserWebPath()}">{$oUserList->getLogin()}</a>
							{if $oUserNote}
								<i class="icon-comment js-infobox" title="{$oUserNote->getText()|escape:'html'}"></i>
							{/if}
						</p>
					</td>
					{if $oUserCurrent}{if $oUserCurrent->isAdministrator() || $oUserCurrent->isGlobalModerator()}<td class="cell-email">{$oUserList->getMail()}</td>{/if}{/if}
					<td class="cell-date">{if $oSession}{date_format date=$oSession->getDateLast() format="d.m.y, H:i"} 
						{if $oUserCurrent}{if $oUserCurrent->isAdministrator() || $oUserCurrent->isGlobalModerator()}
							({$oSession->getIpLast()})
						{/if}{/if}
					{/if}</td>
					<td class="cell-date">{date_format date=$oUserList->getDateRegister() format="d.m.y, H:i"}{if $oUserCurrent}{if $oUserCurrent->isAdministrator() || $oUserCurrent->isGlobalModerator()}
							({$oUserList->getIpRegister()})
						{/if}{/if}</td>
					<td class="cell-skill">{$oUserList->getSkill()}</td>
					<td class="cell-rating"><strong>{$oUserList->getRating()}</strong></td>
				</tr>
			{/foreach}
		{else}
			<tr>
				<td colspan="5">
					{if $sUserListEmpty}
						{$sUserListEmpty}
					{else}
						{$aLang.user_empty}
					{/if}
				</td>
			</tr>
		{/if}
	</tbody>
</table>


{include file='paging.tpl' aPaging=$aPaging}
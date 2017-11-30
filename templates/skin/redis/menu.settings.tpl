<h3 class="profile-page-header">{$aLang.settings_menu}</h3>


<ul class="nav nav-pills">
	<li {if $sMenuSubItemSelect=='profile'}class="active"{/if}><a href="{router page='settings'}profile/">{$aLang.settings_menu_profile}</a></li>
	<li {if $sMenuSubItemSelect=='account'}class="active"{/if}><a href="{router page='settings'}account/">{$aLang.settings_menu_account}</a></li>
	<li {if $sMenuSubItemSelect=='tuning'}class="active"{/if}><a href="{router page='settings'}tuning/">{$aLang.settings_menu_tuning}</a></li>
	<li {if $sMenuSubItemSelect=='behavior'}class="active"{/if}><a href="{router page='settings'}behavior/">{$aLang.settings_menu_behavior}</a></li>
	
	{if $oConfig->GetValue('general.reg.invite')}
		<li {if $sMenuItemSelect=='invite'}class="active"{/if}>
			<a href="{router page='settings'}invite/">{$aLang.settings_menu_invite}</a>
		</li>
	{/if}

	{hook run='menu_settings_settings_item'}
</ul>

{hook run='menu_settings'}
		
		
		

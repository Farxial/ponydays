<nav class="navbar navbar-default">
    <div class="container-fluid nav nav-main">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <ul class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">

                <li {if $sMenuHeadItemSelect=='blog'}class="active"{/if}><a href="/">{$aLang.topic_title}</a></li>
                <li {if $sMenuHeadItemSelect=='blogs'}class="active"{/if}><a
                            href="{router page='blogs'}">{$aLang.blogs}</a></li>
                <li {if $sMenuHeadItemSelect=='people'}class="active"{/if}><a
                            href="{router page='people'}">{$aLang.people}</a></li>
                <li {if $sMenuHeadItemSelect=='stream'}class="active"{/if}><a
                            href="{router page='stream'}">{$aLang.stream_menu}</a></li>
                <li {if $sMenuHeadItemSelect=='feedbacks'}class="active"{/if}><a
                            href="{router page='feedbacks'}">{$aLang.feedbacks.header}</a></li>
                <li {if $sMenuHeadItemSelect=='quotes'}class="active"{/if}><a
                            href="{router page='quotes'}">{$aLang.quotes_title}</a></li>
                <li id="NYtimer"><a href="#" onclick="return false;"><script type="text/javascript">
                            timeend= new Date();
                            // IE и FF по разному отрабатывают getYear()
                            timeend= new Date(timeend.getYear()>1900?(timeend.getYear()+1):(timeend.getYear()+1901),0,1);
                            // для задания обратного отсчета до определенной даты укажите дату в формате:
                            // timeend= new Date(ГОД, МЕСЯЦ-1, ДЕНЬ);
                            // Для задания даты с точностью до времени укажите дату в формате:
                            // timeend= new Date(ГОД, МЕСЯЦ-1, ДЕНЬ, ЧАСЫ-1, МИНУТЫ);
                            function time() {
                                today = new Date();
                                today = Math.floor((timeend-today)/1000);
                                tsec=today%60; today=Math.floor(today/60); if(tsec<10)tsec='0'+tsec;
                                tmin=today%60; today=Math.floor(today/60); if(tmin<10)tmin='0'+tmin;
                                thour=today%24; today=Math.floor(today/24);
                                timestr=today +" дней "+ thour+" часов "+tmin+" минут "+tsec+" секунд";
                                document.getElementById('t').innerHTML=timestr;
                                window.setTimeout("time()",1000);
                            }
                        </script>

                        <span id="timer">До нового года осталось:<br/> <span id="t" style="font-size:16px"></span></p></span>
                        <script>time()</script></a></li>
                {hook run='main_menu_item'}
            </ul>
            <ul class="nav navbar-nav navbar-right" id="navbar-right-big">
                {if $oUserCurrent}
                    <li id="head_collaps" title="Свернуть/развернуть шапку">
                        <i class="material-icons">keyboard_arrow_up</i>
                    </li>
                    <li>
                        <a class="iconic" title="Написать пост" href="{router page='topic'}add/" id="modal_write_show"><i
                                    class="material-icons">mode_edit</i></a>
                    </li>
                    <li>
                        <a class="iconic" title="Ответы" href="{router page='feedbacks'}"><i class="material-icons">question_answer</i></a>
                    </li>
                    <li>
                        <a class="iconic" title="Избранное" href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><i
                                    class="material-icons">favorite</i></a>
                    </li>
                    <li>
                        <a class="iconic" title="Настройки" href="{router page='settings'}profile/"><i class="material-icons">settings</i></a>
                    </li>
                    <li>
                        <a class="iconic" title="Выход"
                           href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}"><i
                                    class="material-icons">exit_to_app</i></a>
                    </li>
                {else}
                    <li id="head_collaps"  title="Свернуть/развернуть шапку">
                        <i class="material-icons">keyboard_arrow_up</i>
                    </li>
                    <li><a title="Войти" href="{router page='login'}" class="js-login-form-show">{$aLang.user_login_submit}</a></li>
                    <li><a title="Регистрация" href="{router page='registration'}"
                           class="js-registration-form-show">{$aLang.registration_submit}</a></li>
                {/if}
                <li>
                    <a href="{if $oUserCurrent}{$oUserCurrent->getUserWebPath()}{/if}"  title="{if $oUserCurrent}{$oUserCurrent->getLogin()}{/if}"
                       class="user-wrapper {if $oUserCurrent}with-login{/if}">{if $oUserCurrent}{$oUserCurrent->getLogin()}{/if}
                        <span class="avatar-wrapper"><img
                                    src="{if $oUserCurrent}{$oUserCurrent->getProfileAvatarPath(48)}{else}https://chenhan1218.github.io/img/profile.png{/if}"
                                    alt="avatar" class="avatar"/></span></a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right" id="navbar-right-small">
                <li class="with_dropd">
                    <a href="{if $oUserCurrent}{$oUserCurrent->getUserWebPath()}{/if}"
                       class="user-wrapper">{if $oUserCurrent}{/if}
                        <span class="avatar-wrapper"><img
                                    src="{if $oUserCurrent}{$oUserCurrent->getProfileAvatarPath(48)}{else}https://chenhan1218.github.io/img/profile.png{/if}"
                                    alt="avatar" class="avatar"/></span></a>
                    <ul class="dropd">
                        {if $oUserCurrent}
                            <li id="head_collaps" title="Свернуть/развернуть шапку">
                                <i class="material-icons">keyboard_arrow_up</i>
                            </li>
                            <li>
                                <a class="iconic" title="Написать пост" href="{router page='topic'}add/" id="modal_write_show"><i
                                            class="material-icons">mode_edit</i></a>
                            </li>
                            <li>
                                <a class="iconic" title="Ответы" href="{router page='feedbacks'}"><i class="material-icons">question_answer</i></a>
                            </li>
                            <li>
                                <a class="iconic" title="Избранное" href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><i
                                            class="material-icons">favorite</i></a>
                            </li>
                            <li>
                                <a class="iconic" title="Настройки" href="{router page='settings'}profile/"><i class="material-icons">settings</i></a>
                            </li>
                            <li>
                                <a class="iconic" title="Выход"
                                   href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}"><i
                                            class="material-icons">exit_to_app</i></a>
                            </li>
                        {else}
                            <li id="head_collaps"  title="Свернуть/развернуть шапку">
                                <i class="material-icons">keyboard_arrow_up</i>
                            </li>
                            <li><a title="Войти" href="{router page='login'}" class="js-login-form-show">{$aLang.user_login_submit}</a></li>
                            <li><a title="Регистрация" href="{router page='registration'}"
                                   class="js-registration-form-show">{$aLang.registration_submit}</a></li>
                        {/if}
                    </ul>
                </li>
            </ul>
    </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

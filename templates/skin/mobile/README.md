Template "Mobile"
=================

Мобильный шаблон для LiveStreet CMS.

Версия 1.0

Поддерживается LiveStreet 1.0.2

Установка шаблона
=================
* Скопировать шаблон в каталог /templates/skin/ своего сайта
* Скопировать плагин из /шаблон/plugin/ в каталог плагинов вашего сайта /plugins/
* Через панель администратора активировать плагин "Mobile Template"

Прописывать шаблон в конфиге НЕ НУЖНО.

Теперь если пользователь зайдет на сайт с мобильного устройства, у которого ширина экрана меньше 1024px, то ему автоматически будет показываться мобильная версия сайта.
Для переключения между версиями в низу сайта доступны специальные ссылки.

Если вы хотите создать свой мобильный шаблон, то в конфиге плагина можно задать название нового мобильного шаблона.

Если вы используете на сайте другие плагины и хотите их адаптировать к мобильному шаблону, то у вас есть два варианта:

1. Создать адаптацию под мобильный шаблон в каталоге /templates/skin/mobile/  необходимого плагина, по аналогии с адаптацией под любой другой шаблон.
2. Отключить функционал необходимого плагина в мобильном шаблоне.

  Обычно для отключения визуального функционала плагина достаточно отключить используемые плагином хуки. Или отключить делегирование/наследование шаблонов/классов.
  Для этого в плагине мобильного шаблона есть специальный метод `MobileDetect::IsMobileTemplate()`, использовать этот метод необходимо совместно с проверкой на существование класса `if (class_exists('MobileDetect') && MobileDetect::IsMobileTemplate()) {  }`
  
  Для примера рассмотрим адаптацию(отключение) плагина Flow под мобильную версию:
  ```
  // Основной файл плагина PluginFlow.class.php
  public function __construct() {
    if (class_exists('MobileDetect') && MobileDetect::IsMobileTemplate()) {
  		// удаляем переопределение шаблонов и классов экшенов
			unset($this->aInherits['template']);
			unset($this->aInherits['action']);
		}
	}
  ```
  ```
  // Файл хуков classes/hooks/HookMain.class.php
    public function RegisterHook() {
		....
		/**
		 * Только если не используется мобильная версия
		 */
		if (!(class_exists('MobileDetect') && MobileDetect::IsMobileTemplate())) {
			$this->AddHook('template_wrapper_class', 'AddWrapperClass', __CLASS__);
			$this->AddHook('template_container_class', 'AddContainerClass', __CLASS__);
		}
    }
  ```

История
=================
1.0

- Релиз
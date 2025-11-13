#!/bin/bash

MODULE_DIR="ocmod_newest_sort_fanes_correct"
mkdir -p "$MODULE_DIR"

cat > "$MODULE_DIR/install.xml" << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<modification>
    <name>Newest Sort for Fanes Theme - Corrected</name>
    <code>newest_sort_fanes_correct</code>
    <version>2.3.0</version>
    <author>Adapted for Fanes</author>
    <link>https://github.com/evollved</link>

    <!-- Добавление языковых переменных -->
    <file path="catalog/language/ru-ru/product/category.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Сначала новые';
            ]]></add>
        </operation>
    </file>

    <file path="catalog/language/ru-ru/product/search.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Сначала новые';
            ]]></add>
        </operation>
    </file>

    <file path="catalog/language/ru-ru/product/special.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Сначала новые';
            ]]></add>
        </operation>
    </file>

    <file path="catalog/language/ru-ru/product/manufacturer.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Сначала новые';
            ]]></add>
        </operation>
    </file>

    <file path="catalog/language/en-gb/product/category.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Newest first';
            ]]></add>
        </operation>
    </file>

    <file path="catalog/language/en-gb/product/search.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Newest first';
            ]]></add>
        </operation>
    </file>

    <file path="catalog/language/en-gb/product/special.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Newest first';
            ]]></add>
        </operation>
    </file>

    <file path="catalog/language/en-gb/product/manufacturer.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$_['text_model_asc']]]></search>
            <add position="before"><![CDATA[
$_['text_date_added_desc'] = 'Newest first';
            ]]></add>
        </operation>
    </file>

    <!-- Модификация контроллера категории -->
    <file path="catalog/controller/product/category.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$data['sorts'] = array();]]></search>
            <add position="after"><![CDATA[
		// Сортировка по новизне
		$url = '';

		if (isset($this->request->get['filter'])) {
			$url .= '&filter=' . $this->request->get['filter'];
		}

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
            ]]></add>
        </operation>
        <operation error="skip">
            <search><![CDATA[$data['sorts'][] = array(]]></search>
            <add position="before"><![CDATA[
		$data['sorts'][] = array(
			'text'  => $this->language->get('text_date_added_desc'),
			'value' => 'p.date_added-DESC',
			'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.date_added&order=DESC' . $url)
		);
            ]]></add>
        </operation>
    </file>

    <!-- Модификация контроллера производителя -->
    <file path="catalog/controller/product/manufacturer.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$data['sorts'] = array();]]></search>
            <add position="after"><![CDATA[
		// Сортировка по новизне
		$url = '';

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
            ]]></add>
        </operation>
        <operation error="skip">
            <search><![CDATA[$data['sorts'][] = array(]]></search>
            <add position="before"><![CDATA[
		$data['sorts'][] = array(
			'text'  => $this->language->get('text_date_added_desc'),
			'value' => 'p.date_added-DESC',
			'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=p.date_added&order=DESC' . $url)
		);
            ]]></add>
        </operation>
    </file>

    <!-- Модификация контроллера поиска -->
    <file path="catalog/controller/product/search.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$data['sorts'] = array();]]></search>
            <add position="after"><![CDATA[
		// Сортировка по новизне
		$url = '';

		if (isset($this->request->get['search'])) {
			$url .= '&search=' . urlencode(html_entity_decode($this->request->get['search'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['tag'])) {
			$url .= '&tag=' . urlencode(html_entity_decode($this->request->get['tag'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['description'])) {
			$url .= '&description=' . $this->request->get['description'];
		}

		if (isset($this->request->get['category_id'])) {
			$url .= '&category_id=' . $this->request->get['category_id'];
		}

		if (isset($this->request->get['sub_category'])) {
			$url .= '&sub_category=' . $this->request->get['sub_category'];
		}

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
            ]]></add>
        </operation>
        <operation error="skip">
            <search><![CDATA[$data['sorts'][] = array(]]></search>
            <add position="before"><![CDATA[
		$data['sorts'][] = array(
			'text'  => $this->language->get('text_date_added_desc'),
			'value' => 'p.date_added-DESC',
			'href'  => $this->url->link('product/search', $url . '&sort=p.date_added&order=DESC')
		);
            ]]></add>
        </operation>
    </file>

    <!-- Модификация контроллера специальных предложений -->
    <file path="catalog/controller/product/special.php" error="skip">
        <operation error="skip">
            <search><![CDATA[$data['sorts'] = array();]]></search>
            <add position="after"><![CDATA[
		// Сортировка по новизне
		$url = '';

		if (isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}
            ]]></add>
        </operation>
        <operation error="skip">
            <search><![CDATA[$data['sorts'][] = array(]]></search>
            <add position="before"><![CDATA[
		$data['sorts'][] = array(
			'text'  => $this->language->get('text_date_added_desc'),
			'value' => 'p.date_added-DESC',
			'href'  => $this->url->link('product/special', 'sort=p.date_added&order=DESC' . $url)
		);
            ]]></add>
        </operation>
    </file>

</modification>
EOF

# Создание архива
cd "$MODULE_DIR" && zip -r ../ocmod_newest_sort_fanes_correct.ocmod.zip ./* && cd .. && rm -rf "$MODULE_DIR"

echo "✅ Модуль ocmod_newest_sort_fanes_correct.ocmod.zip создан!"
echo ""
echo "📋 Инструкция по установке:"
echo "1. Удалите старые версии модуля через 'Расширения → Установщик'"
echo "2. Загрузите новый файл ocmod_newest_sort_fanes_correct.ocmod.zip"
echo "3. Обновите кэш модификаций в 'Расширения → Модификации'"
echo "4. Проверьте работу сортировки на сайте"
echo ""
echo "🔧 Ключевые исправления:"
echo "   - Правильная инициализация переменной \$url в каждом контроллере"
echo "   - Исправлено формирование URL для поиска (параметры добавляются перед сортировкой)"
echo "   - Убрана модификация модели, так как 'p.date_added' уже есть в массиве sort_data"
echo ""
echo "⚠️  ВАЖНО: Модель уже поддерживает сортировку по 'p.date_added', поэтому дополнительная модификация не нужна!"
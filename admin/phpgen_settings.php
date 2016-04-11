<?php

//  define('SHOW_VARIABLES', 1);
//  define('DEBUG_LEVEL', 1);

//  error_reporting(E_ALL ^ E_NOTICE);
//  ini_set('display_errors', 'On');

require_once __DIR__ . '/../classes/maestro.config.php';

set_include_path('.' . PATH_SEPARATOR . get_include_path());


include_once dirname(__FILE__) . '/' . 'components/utils/system_utils.php';

//  SystemUtils::DisableMagicQuotesRuntime();

SystemUtils::SetTimeZoneIfNeed('Europe/Minsk');

function HasAdminPage()
{
    return false;
}

function GetPageGroups()
{
    $result = array('Default');
    return $result;
}

function GetPageInfos()
{
    $result = array();
    $result[] = array('caption' => 'Articles', 'short_caption' => 'Main.Articles', 'filename' => 'articles.php', 'name' => 'main.articles', 'group_name' => 'Default', 'add_separator' => false);
    $result[] = array('caption' => 'Agents', 'short_caption' => 'Main.Agents', 'filename' => 'agents.php', 'name' => 'main.agents', 'group_name' => 'Default', 'add_separator' => false);
    $result[] = array('caption' => 'Agent Fields', 'short_caption' => 'Main.Agent Fields', 'filename' => 'agent_fields.php', 'name' => 'main.agent_fields', 'group_name' => 'Default', 'add_separator' => false);
    $result[] = array('caption' => 'Field Types', 'short_caption' => 'Main.Field Types', 'filename' => 'field_types.php', 'name' => 'main.field_types', 'group_name' => 'Default', 'add_separator' => true);
    $result[] = array('caption' => 'Logins', 'short_caption' => 'Main.Logins', 'filename' => 'logins.php', 'name' => 'main.logins', 'group_name' => 'Default', 'add_separator' => false);
    $result[] = array('caption' => 'Languages', 'short_caption' => 'Main.Languages', 'filename' => 'languages.php', 'name' => 'main.languages', 'group_name' => 'Default', 'add_separator' => false);
    $result[] = array('caption' => 'Domains', 'short_caption' => 'Main.Domains', 'filename' => 'domains.php', 'name' => 'main.domains', 'group_name' => 'Default', 'add_separator' => false);
    $result[] = array('caption' => 'Phrases', 'short_caption' => 'Main.Phrases', 'filename' => 'phrases.php', 'name' => 'main.phrases', 'group_name' => 'Default', 'add_separator' => false);
    return $result;
}

function GetPagesHeader()
{
    return
    '';
}

function GetPagesFooter()
{
    return
        ''; 
    }

function ApplyCommonPageSettings(Page $page, Grid $grid)
{
    $page->SetShowUserAuthBar(false);
    $page->OnCustomHTMLHeader->AddListener('Global_CustomHTMLHeaderHandler');
    $page->OnGetCustomTemplate->AddListener('Global_GetCustomTemplateHandler');
    $grid->BeforeUpdateRecord->AddListener('Global_BeforeUpdateHandler');
    $grid->BeforeDeleteRecord->AddListener('Global_BeforeDeleteHandler');
    $grid->BeforeInsertRecord->AddListener('Global_BeforeInsertHandler');
}

/*
  Default code page: 1252
*/
function GetAnsiEncoding() { return 'windows-1252'; }

function Global_CustomHTMLHeaderHandler($page, &$customHtmlHeaderText)
{

}

function Global_GetCustomTemplateHandler($part, $mode, &$result, &$params, Page $page = null)
{

}

function Global_BeforeUpdateHandler($page, &$rowData, &$cancel, &$message, $tableName)
{

}

function Global_BeforeDeleteHandler($page, &$rowData, &$cancel, &$message, $tableName)
{

}

function Global_BeforeInsertHandler($page, &$rowData, &$cancel, &$message, $tableName)
{

}

function GetDefaultDateFormat()
{
    return 'Y-m-d';
}

function GetFirstDayOfWeek()
{
    return 0;
}

function GetEnableLessFilesRunTimeCompilation()
{
    return false;
}



?>
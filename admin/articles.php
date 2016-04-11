<?php
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *                                   ATTENTION!
 * If you see this message in your browser (Internet Explorer, Mozilla Firefox, Google Chrome, etc.)
 * this means that PHP is not properly installed on your web server. Please refer to the PHP manual
 * for more details: http://php.net/manual/install.php 
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 */


    include_once dirname(__FILE__) . '/' . 'components/utils/check_utils.php';
    CheckPHPVersion();
    CheckTemplatesCacheFolderIsExistsAndWritable();


    include_once dirname(__FILE__) . '/' . 'phpgen_settings.php';
    include_once dirname(__FILE__) . '/' . 'database_engine/pgsql_engine.php';
    include_once dirname(__FILE__) . '/' . 'components/page.php';


    function GetConnectionOptions()
    {
        $result = GetGlobalConnectionOptions();
        $result['client_encoding'] = 'utf8';
        GetApplication()->GetUserAuthorizationStrategy()->ApplyIdentityToConnectionOptions($result);
        return $result;
    }

    
    // OnGlobalBeforePageExecute event handler
    
    
    // OnBeforePageExecute event handler
    
    
    
    class main_articlesPage extends Page
    {
        protected function DoBeforeCreate()
        {
            $this->dataset = new TableDataset(
                new PgConnectionFactory(),
                GetConnectionOptions(),
                '"main"."articles"');
            $field = new IntegerField('id', null, null, true);
            $field->SetIsNotNull(true);
            $this->dataset->AddField($field, true);
            $field = new StringField('name');
            $this->dataset->AddField($field, false);
            $field = new StringField('guid');
            $this->dataset->AddField($field, false);
            $field = new IntegerField('domain_id');
            $field->SetIsNotNull(true);
            $this->dataset->AddField($field, false);
            $field = new IntegerField('lang_id');
            $field->SetIsNotNull(true);
            $this->dataset->AddField($field, false);
            $field = new StringField('category');
            $this->dataset->AddField($field, false);
            $field = new StringField('subcategory');
            $this->dataset->AddField($field, false);
            $field = new StringField('picture');
            $this->dataset->AddField($field, false);
            $field = new DateField('date1');
            $this->dataset->AddField($field, false);
            $field = new DateField('date2');
            $this->dataset->AddField($field, false);
            $field = new StringField('text1');
            $this->dataset->AddField($field, false);
            $field = new StringField('text2');
            $this->dataset->AddField($field, false);
            $field = new StringField('article_text');
            $this->dataset->AddField($field, false);
            $field = new IntegerField('order_value');
            $field->SetIsNotNull(true);
            $this->dataset->AddField($field, false);
            $this->dataset->AddLookupField('domain_id', '"main".domains', new IntegerField('id', null, null, true), new StringField('domain_name', 'domain_id_domain_name', 'domain_id_domain_name_main_domains'), 'domain_id_domain_name_main_domains');
            $this->dataset->AddLookupField('lang_id', '"main".languages', new IntegerField('id', null, null, true), new StringField('full_name', 'lang_id_full_name', 'lang_id_full_name_main_languages'), 'lang_id_full_name_main_languages');
        }
    
        protected function DoPrepare() {
    
        }
    
        protected function CreatePageNavigator()
        {
            $result = new CompositePageNavigator($this);
            
            $partitionNavigator = new PageNavigator('pnav', $this, $this->dataset);
            $partitionNavigator->SetRowsPerPage(20);
            $result->AddPageNavigator($partitionNavigator);
            
            return $result;
        }
    
        public function GetPageList()
        {
            $currentPageCaption = $this->GetShortCaption();
            $result = new PageList($this);
            $result->AddGroup($this->RenderText('Default'));
			
			if (GetCurrentUserGrantForDataSource('Pictures')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Pictures'), 'index.php', $this->RenderText('Pictures'), $currentPageCaption == $this->RenderText('Pictures'), false, $this->RenderText('Default')));
			
            if (GetCurrentUserGrantForDataSource('main.articles')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Articles'), 'articles.php', $this->RenderText('Main.Articles'), $currentPageCaption == $this->RenderText('Articles'), true, $this->RenderText('Default')));
            if (GetCurrentUserGrantForDataSource('main.agents')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Agents'), 'agents.php', $this->RenderText('Main.Agents'), $currentPageCaption == $this->RenderText('Agents'), false, $this->RenderText('Default')));
            if (GetCurrentUserGrantForDataSource('main.agent_fields')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Agent Fields'), 'agent_fields.php', $this->RenderText('Main.Agent Fields'), $currentPageCaption == $this->RenderText('Agent Fields'), false, $this->RenderText('Default')));
            if (GetCurrentUserGrantForDataSource('main.field_types')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Field Types'), 'field_types.php', $this->RenderText('Main.Field Types'), $currentPageCaption == $this->RenderText('Field Types'), true, $this->RenderText('Default')));
            if (GetCurrentUserGrantForDataSource('main.logins')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Logins'), 'logins.php', $this->RenderText('Main.Logins'), $currentPageCaption == $this->RenderText('Logins'), false, $this->RenderText('Default')));
            if (GetCurrentUserGrantForDataSource('main.languages')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Languages'), 'languages.php', $this->RenderText('Main.Languages'), $currentPageCaption == $this->RenderText('Languages'), false, $this->RenderText('Default')));
            if (GetCurrentUserGrantForDataSource('main.domains')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Domains'), 'domains.php', $this->RenderText('Main.Domains'), $currentPageCaption == $this->RenderText('Domains'), false, $this->RenderText('Default')));
            if (GetCurrentUserGrantForDataSource('main.phrases')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Phrases'), 'phrases.php', $this->RenderText('Main.Phrases'), $currentPageCaption == $this->RenderText('Phrases'), false, $this->RenderText('Default')));
			
			if (GetCurrentUserGrantForDataSource('Logout')->HasViewGrant())
                $result->AddPage(new PageLink($this->RenderText('Logout'), 'index.php?logout', $this->RenderText('Logout'), $currentPageCaption == $this->RenderText('Logout'), true, $this->RenderText('Default')));
            
            if ( HasAdminPage() && GetApplication()->HasAdminGrantForCurrentUser() ) {
              $result->AddGroup('Admin area');
              $result->AddPage(new PageLink($this->GetLocalizerCaptions()->GetMessageString('AdminPage'), 'phpgen_admin.php', $this->GetLocalizerCaptions()->GetMessageString('AdminPage'), false, false, 'Admin area'));
            }
            return $result;
        }
    
        protected function CreateRssGenerator()
        {
            return null;
        }
    
        protected function CreateGridSearchControl(Grid $grid)
        {
            $grid->UseFilter = true;
            $grid->SearchControl = new SimpleSearch('main_articlesssearch', $this->dataset,
                array('id', 'name', 'guid', 'domain_id_domain_name', 'lang_id_full_name', 'category', 'subcategory', 'picture', 'text1', 'text2', 'article_text', 'order_value'),
                array($this->RenderText('Id'), $this->RenderText('Name'), $this->RenderText('Guid'), $this->RenderText('Domain Id'), $this->RenderText('Lang Id'), $this->RenderText('Category'), $this->RenderText('Subcategory'), $this->RenderText('Picture'), $this->RenderText('Text1'), $this->RenderText('Text2'), $this->RenderText('Article Text'), $this->RenderText('Order Value')),
                array(
                    '=' => $this->GetLocalizerCaptions()->GetMessageString('equals'),
                    '<>' => $this->GetLocalizerCaptions()->GetMessageString('doesNotEquals'),
                    '<' => $this->GetLocalizerCaptions()->GetMessageString('isLessThan'),
                    '<=' => $this->GetLocalizerCaptions()->GetMessageString('isLessThanOrEqualsTo'),
                    '>' => $this->GetLocalizerCaptions()->GetMessageString('isGreaterThan'),
                    '>=' => $this->GetLocalizerCaptions()->GetMessageString('isGreaterThanOrEqualsTo'),
                    'ILIKE' => $this->GetLocalizerCaptions()->GetMessageString('Like'),
                    'STARTS' => $this->GetLocalizerCaptions()->GetMessageString('StartsWith'),
                    'ENDS' => $this->GetLocalizerCaptions()->GetMessageString('EndsWith'),
                    'CONTAINS' => $this->GetLocalizerCaptions()->GetMessageString('Contains')
                    ), $this->GetLocalizerCaptions(), $this, 'CONTAINS'
                );
        }
    
        protected function CreateGridAdvancedSearchControl(Grid $grid)
        {
            $this->AdvancedSearchControl = new AdvancedSearchControl('main_articlesasearch', $this->dataset, $this->GetLocalizerCaptions(), $this->GetColumnVariableContainer(), $this->CreateLinkBuilder());
            $this->AdvancedSearchControl->setTimerInterval(1000);
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('id', $this->RenderText('Id')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('name', $this->RenderText('Name')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('guid', $this->RenderText('Guid')));
            
            $lookupDataset = new TableDataset(
                new PgConnectionFactory(),
                GetConnectionOptions(),
                '"main"."domains"');
            $field = new IntegerField('id', null, null, true);
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, true);
            $field = new StringField('domain_name');
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, false);
            $field = new IntegerField('default_lang_id');
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, false);
            $field = new StringField('site_domain_name');
            $lookupDataset->AddField($field, false);
            $lookupDataset->setOrderByField('domain_name', GetOrderTypeAsSQL(otAscending));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateLookupSearchInput('domain_id', $this->RenderText('Domain Id'), $lookupDataset, 'id', 'domain_name', false, 8));
            
            $lookupDataset = new TableDataset(
                new PgConnectionFactory(),
                GetConnectionOptions(),
                '"main"."languages"');
            $field = new IntegerField('id', null, null, true);
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, true);
            $field = new StringField('shortest_name');
            $lookupDataset->AddField($field, false);
            $field = new StringField('short_name');
            $lookupDataset->AddField($field, false);
            $field = new StringField('full_name');
            $lookupDataset->AddField($field, false);
            $lookupDataset->setOrderByField('full_name', GetOrderTypeAsSQL(otAscending));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateLookupSearchInput('lang_id', $this->RenderText('Lang Id'), $lookupDataset, 'id', 'full_name', false, 8));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('category', $this->RenderText('Category')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('subcategory', $this->RenderText('Subcategory')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('picture', $this->RenderText('Picture')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('text1', $this->RenderText('Text1')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('text2', $this->RenderText('Text2')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('article_text', $this->RenderText('Article Text')));
            $this->AdvancedSearchControl->AddSearchColumn($this->AdvancedSearchControl->CreateStringSearchInput('order_value', $this->RenderText('Order Value')));
        }
    
        protected function AddOperationsColumns(Grid $grid)
        {
            $actionsBandName = 'actions';
            $grid->AddBandToBegin($actionsBandName, $this->GetLocalizerCaptions()->GetMessageString('Actions'), true);
            if ($this->GetSecurityInfo()->HasViewGrant())
            {
                $column = new RowOperationByLinkColumn($this->GetLocalizerCaptions()->GetMessageString('View'), OPERATION_VIEW, $this->dataset);
                $grid->AddViewColumn($column, $actionsBandName);
            }
            if ($this->GetSecurityInfo()->HasEditGrant())
            {
                $column = new RowOperationByLinkColumn($this->GetLocalizerCaptions()->GetMessageString('Edit'), OPERATION_EDIT, $this->dataset);
                $grid->AddViewColumn($column, $actionsBandName);
                $column->OnShow->AddListener('ShowEditButtonHandler', $this);
            }
            if ($this->GetSecurityInfo()->HasDeleteGrant())
            {
                $column = new RowOperationByLinkColumn($this->GetLocalizerCaptions()->GetMessageString('Delete'), OPERATION_DELETE, $this->dataset);
                $grid->AddViewColumn($column, $actionsBandName);
                $column->OnShow->AddListener('ShowDeleteButtonHandler', $this);
                $column->SetAdditionalAttribute('data-modal-delete', 'true');
                $column->SetAdditionalAttribute('data-delete-handler-name', $this->GetModalGridDeleteHandler());
            }
            if ($this->GetSecurityInfo()->HasAddGrant())
            {
                $column = new RowOperationByLinkColumn($this->GetLocalizerCaptions()->GetMessageString('Copy'), OPERATION_COPY, $this->dataset);
                $grid->AddViewColumn($column, $actionsBandName);
            }
        }
    
        protected function AddFieldColumns(Grid $grid)
        {
            //
            // View column for id field
            //
            $column = new TextViewColumn('id', 'Id', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for name field
            //
            $column = new TextViewColumn('name', 'Name', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for guid field
            //
            $column = new TextViewColumn('guid', 'Guid', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for domain_name field
            //
            $column = new TextViewColumn('domain_id_domain_name', 'Domain Id', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for full_name field
            //
            $column = new TextViewColumn('lang_id_full_name', 'Lang Id', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for category field
            //
            $column = new TextViewColumn('category', 'Category', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for subcategory field
            //
            $column = new TextViewColumn('subcategory', 'Subcategory', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for picture field
            //
            $column = new TextViewColumn('picture', 'Picture', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_picture_handler_list');
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for text1 field
            //
            $column = new TextViewColumn('text1', 'Text1', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_text1_handler_list');
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for text2 field
            //
            $column = new TextViewColumn('text2', 'Text2', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_text2_handler_list');
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for article_text field
            //
            $column = new TextViewColumn('article_text', 'Article Text', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_article_text_handler_list');
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
            
            //
            // View column for order_value field
            //
            $column = new TextViewColumn('order_value', 'Order Value', $this->dataset);
            $column->SetOrderable(true);
            $column->SetDescription($this->RenderText(''));
            $column->SetFixedWidth(null);
            $grid->AddViewColumn($column);
        }
    
        protected function AddSingleRecordViewColumns(Grid $grid)
        {
            //
            // View column for id field
            //
            $column = new TextViewColumn('id', 'Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for name field
            //
            $column = new TextViewColumn('name', 'Name', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for guid field
            //
            $column = new TextViewColumn('guid', 'Guid', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for domain_name field
            //
            $column = new TextViewColumn('domain_id_domain_name', 'Domain Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for full_name field
            //
            $column = new TextViewColumn('lang_id_full_name', 'Lang Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for category field
            //
            $column = new TextViewColumn('category', 'Category', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for subcategory field
            //
            $column = new TextViewColumn('subcategory', 'Subcategory', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for picture field
            //
            $column = new TextViewColumn('picture', 'Picture', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_picture_handler_view');
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for text1 field
            //
            $column = new TextViewColumn('text1', 'Text1', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_text1_handler_view');
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for text2 field
            //
            $column = new TextViewColumn('text2', 'Text2', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_text2_handler_view');
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for article_text field
            //
            $column = new TextViewColumn('article_text', 'Article Text', $this->dataset);
            $column->SetOrderable(true);
            $column->SetMaxLength(75);
            $column->SetFullTextWindowHandlerName('main_articlesGrid_article_text_handler_view');
            $grid->AddSingleRecordViewColumn($column);
            
            //
            // View column for order_value field
            //
            $column = new TextViewColumn('order_value', 'Order Value', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddSingleRecordViewColumn($column);
        }
    
        protected function AddEditColumns(Grid $grid)
        {
            //
            // Edit column for name field
            //
            $editor = new TextEdit('name_edit');
            $editor->SetSize(50);
            $editor->SetMaxLength(50);
            $editColumn = new CustomEditColumn('Name', 'name', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for guid field
            //
            $editor = new TextEdit('guid_edit');
            $editColumn = new CustomEditColumn('Guid', 'guid', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for domain_id field
            //
            $editor = new ComboBox('domain_id_edit', $this->GetLocalizerCaptions()->GetMessageString('PleaseSelect'));
            $lookupDataset = new TableDataset(
                new PgConnectionFactory(),
                GetConnectionOptions(),
                '"main"."domains"');
            $field = new IntegerField('id', null, null, true);
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, true);
            $field = new StringField('domain_name');
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, false);
            $field = new IntegerField('default_lang_id');
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, false);
            $field = new StringField('site_domain_name');
            $lookupDataset->AddField($field, false);
            $lookupDataset->setOrderByField('domain_name', GetOrderTypeAsSQL(otAscending));
            $editColumn = new LookUpEditColumn(
                'Domain Id', 
                'domain_id', 
                $editor, 
                $this->dataset, 'id', 'domain_name', $lookupDataset);
            $validator = new RequiredValidator(StringUtils::Format($this->GetLocalizerCaptions()->GetMessageString('RequiredValidationMessage'), $this->RenderText($editColumn->GetCaption())));
            $editor->GetValidatorCollection()->AddValidator($validator);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for lang_id field
            //
            $editor = new ComboBox('lang_id_edit', $this->GetLocalizerCaptions()->GetMessageString('PleaseSelect'));
            $lookupDataset = new TableDataset(
                new PgConnectionFactory(),
                GetConnectionOptions(),
                '"main"."languages"');
            $field = new IntegerField('id', null, null, true);
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, true);
            $field = new StringField('shortest_name');
            $lookupDataset->AddField($field, false);
            $field = new StringField('short_name');
            $lookupDataset->AddField($field, false);
            $field = new StringField('full_name');
            $lookupDataset->AddField($field, false);
            $lookupDataset->setOrderByField('full_name', GetOrderTypeAsSQL(otAscending));
            $editColumn = new LookUpEditColumn(
                'Lang Id', 
                'lang_id', 
                $editor, 
                $this->dataset, 'id', 'full_name', $lookupDataset);
            $validator = new RequiredValidator(StringUtils::Format($this->GetLocalizerCaptions()->GetMessageString('RequiredValidationMessage'), $this->RenderText($editColumn->GetCaption())));
            $editor->GetValidatorCollection()->AddValidator($validator);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for category field
            //
            $editor = new TextEdit('category_edit');
            $editor->SetSize(50);
            $editor->SetMaxLength(50);
            $editColumn = new CustomEditColumn('Category', 'category', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for subcategory field
            //
            $editor = new TextEdit('subcategory_edit');
            $editor->SetSize(50);
            $editor->SetMaxLength(50);
            $editColumn = new CustomEditColumn('Subcategory', 'subcategory', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for picture field
            //
            $editor = new TextAreaEdit('picture_edit', 50, 8);
            $editColumn = new CustomEditColumn('Picture', 'picture', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for text1 field
            //
            $editor = new TextAreaEdit('text1_edit', 50, 8);
            $editColumn = new CustomEditColumn('Text1', 'text1', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for text2 field
            //
            $editor = new TextAreaEdit('text2_edit', 50, 8);
            $editColumn = new CustomEditColumn('Text2', 'text2', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for article_text field
            //
            $editor = new TextAreaEdit('article_text_edit', 50, 8);
            $editColumn = new CustomEditColumn('Article Text', 'article_text', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
            
            //
            // Edit column for order_value field
            //
            $editor = new TextEdit('order_value_edit');
            $editColumn = new CustomEditColumn('Order Value', 'order_value', $editor, $this->dataset);
            $validator = new RequiredValidator(StringUtils::Format($this->GetLocalizerCaptions()->GetMessageString('RequiredValidationMessage'), $this->RenderText($editColumn->GetCaption())));
            $editor->GetValidatorCollection()->AddValidator($validator);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddEditColumn($editColumn);
        }
    
        protected function AddInsertColumns(Grid $grid)
        {
            //
            // Edit column for name field
            //
            $editor = new TextEdit('name_edit');
            $editor->SetSize(50);
            $editor->SetMaxLength(50);
            $editColumn = new CustomEditColumn('Name', 'name', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for guid field
            //
            $editor = new TextEdit('guid_edit');
            $editColumn = new CustomEditColumn('Guid', 'guid', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for domain_id field
            //
            $editor = new ComboBox('domain_id_edit', $this->GetLocalizerCaptions()->GetMessageString('PleaseSelect'));
            $lookupDataset = new TableDataset(
                new PgConnectionFactory(),
                GetConnectionOptions(),
                '"main"."domains"');
            $field = new IntegerField('id', null, null, true);
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, true);
            $field = new StringField('domain_name');
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, false);
            $field = new IntegerField('default_lang_id');
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, false);
            $field = new StringField('site_domain_name');
            $lookupDataset->AddField($field, false);
            $lookupDataset->setOrderByField('domain_name', GetOrderTypeAsSQL(otAscending));
            $editColumn = new LookUpEditColumn(
                'Domain Id', 
                'domain_id', 
                $editor, 
                $this->dataset, 'id', 'domain_name', $lookupDataset);
            $validator = new RequiredValidator(StringUtils::Format($this->GetLocalizerCaptions()->GetMessageString('RequiredValidationMessage'), $this->RenderText($editColumn->GetCaption())));
            $editor->GetValidatorCollection()->AddValidator($validator);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for lang_id field
            //
            $editor = new ComboBox('lang_id_edit', $this->GetLocalizerCaptions()->GetMessageString('PleaseSelect'));
            $lookupDataset = new TableDataset(
                new PgConnectionFactory(),
                GetConnectionOptions(),
                '"main"."languages"');
            $field = new IntegerField('id', null, null, true);
            $field->SetIsNotNull(true);
            $lookupDataset->AddField($field, true);
            $field = new StringField('shortest_name');
            $lookupDataset->AddField($field, false);
            $field = new StringField('short_name');
            $lookupDataset->AddField($field, false);
            $field = new StringField('full_name');
            $lookupDataset->AddField($field, false);
            $lookupDataset->setOrderByField('full_name', GetOrderTypeAsSQL(otAscending));
            $editColumn = new LookUpEditColumn(
                'Lang Id', 
                'lang_id', 
                $editor, 
                $this->dataset, 'id', 'full_name', $lookupDataset);
            $editColumn->SetAllowSetToDefault(true);
            $validator = new RequiredValidator(StringUtils::Format($this->GetLocalizerCaptions()->GetMessageString('RequiredValidationMessage'), $this->RenderText($editColumn->GetCaption())));
            $editor->GetValidatorCollection()->AddValidator($validator);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for category field
            //
            $editor = new TextEdit('category_edit');
            $editor->SetSize(50);
            $editor->SetMaxLength(50);
            $editColumn = new CustomEditColumn('Category', 'category', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for subcategory field
            //
            $editor = new TextEdit('subcategory_edit');
            $editor->SetSize(50);
            $editor->SetMaxLength(50);
            $editColumn = new CustomEditColumn('Subcategory', 'subcategory', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for picture field
            //
            $editor = new TextAreaEdit('picture_edit', 50, 8);
            $editColumn = new CustomEditColumn('Picture', 'picture', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for text1 field
            //
            $editor = new TextAreaEdit('text1_edit', 50, 8);
            $editColumn = new CustomEditColumn('Text1', 'text1', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for text2 field
            //
            $editor = new TextAreaEdit('text2_edit', 50, 8);
            $editColumn = new CustomEditColumn('Text2', 'text2', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for article_text field
            //
            $editor = new TextAreaEdit('article_text_edit', 50, 8);
            $editColumn = new CustomEditColumn('Article Text', 'article_text', $editor, $this->dataset);
            $editColumn->SetAllowSetToNull(true);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            
            //
            // Edit column for order_value field
            //
            $editor = new TextEdit('order_value_edit');
            $editColumn = new CustomEditColumn('Order Value', 'order_value', $editor, $this->dataset);
            $editColumn->SetAllowSetToDefault(true);
            $validator = new RequiredValidator(StringUtils::Format($this->GetLocalizerCaptions()->GetMessageString('RequiredValidationMessage'), $this->RenderText($editColumn->GetCaption())));
            $editor->GetValidatorCollection()->AddValidator($validator);
            $this->ApplyCommonColumnEditProperties($editColumn);
            $grid->AddInsertColumn($editColumn);
            if ($this->GetSecurityInfo()->HasAddGrant())
            {
                $grid->SetShowAddButton(true);
                $grid->SetShowInlineAddButton(false);
            }
            else
            {
                $grid->SetShowInlineAddButton(false);
                $grid->SetShowAddButton(false);
            }
        }
    
        protected function AddPrintColumns(Grid $grid)
        {
            //
            // View column for id field
            //
            $column = new TextViewColumn('id', 'Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for name field
            //
            $column = new TextViewColumn('name', 'Name', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for guid field
            //
            $column = new TextViewColumn('guid', 'Guid', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for domain_name field
            //
            $column = new TextViewColumn('domain_id_domain_name', 'Domain Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for full_name field
            //
            $column = new TextViewColumn('lang_id_full_name', 'Lang Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for category field
            //
            $column = new TextViewColumn('category', 'Category', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for subcategory field
            //
            $column = new TextViewColumn('subcategory', 'Subcategory', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for picture field
            //
            $column = new TextViewColumn('picture', 'Picture', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for text1 field
            //
            $column = new TextViewColumn('text1', 'Text1', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for text2 field
            //
            $column = new TextViewColumn('text2', 'Text2', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for article_text field
            //
            $column = new TextViewColumn('article_text', 'Article Text', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
            
            //
            // View column for order_value field
            //
            $column = new TextViewColumn('order_value', 'Order Value', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddPrintColumn($column);
        }
    
        protected function AddExportColumns(Grid $grid)
        {
            //
            // View column for id field
            //
            $column = new TextViewColumn('id', 'Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for name field
            //
            $column = new TextViewColumn('name', 'Name', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for guid field
            //
            $column = new TextViewColumn('guid', 'Guid', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for domain_name field
            //
            $column = new TextViewColumn('domain_id_domain_name', 'Domain Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for full_name field
            //
            $column = new TextViewColumn('lang_id_full_name', 'Lang Id', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for category field
            //
            $column = new TextViewColumn('category', 'Category', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for subcategory field
            //
            $column = new TextViewColumn('subcategory', 'Subcategory', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for picture field
            //
            $column = new TextViewColumn('picture', 'Picture', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for text1 field
            //
            $column = new TextViewColumn('text1', 'Text1', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for text2 field
            //
            $column = new TextViewColumn('text2', 'Text2', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for article_text field
            //
            $column = new TextViewColumn('article_text', 'Article Text', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
            
            //
            // View column for order_value field
            //
            $column = new TextViewColumn('order_value', 'Order Value', $this->dataset);
            $column->SetOrderable(true);
            $grid->AddExportColumn($column);
        }
    
        public function GetPageDirection()
        {
            return null;
        }
    
        protected function ApplyCommonColumnEditProperties(CustomEditColumn $column)
        {
            $column->SetDisplaySetToNullCheckBox(false);
            $column->SetDisplaySetToDefaultCheckBox(false);
    		$column->SetVariableContainer($this->GetColumnVariableContainer());
        }
    
        function GetCustomClientScript()
        {
            return ;
        }
        
        function GetOnPageLoadedClientScript()
        {
            return ;
        }
        public function ShowEditButtonHandler(&$show)
        {
            if ($this->GetRecordPermission() != null)
                $show = $this->GetRecordPermission()->HasEditGrant($this->GetDataset());
        }
        public function ShowDeleteButtonHandler(&$show)
        {
            if ($this->GetRecordPermission() != null)
                $show = $this->GetRecordPermission()->HasDeleteGrant($this->GetDataset());
        }
        
        public function GetModalGridDeleteHandler() { return 'main_articles_modal_delete'; }
        protected function GetEnableModalGridDelete() { return true; }
    
        protected function CreateGrid()
        {
            $result = new Grid($this, $this->dataset, 'main_articlesGrid');
            if ($this->GetSecurityInfo()->HasDeleteGrant())
               $result->SetAllowDeleteSelected(false);
            else
               $result->SetAllowDeleteSelected(false);   
            
            ApplyCommonPageSettings($this, $result);
            
            $result->SetUseImagesForActions(false);
            $result->SetUseFixedHeader(false);
            $result->SetShowLineNumbers(false);
            $result->SetShowKeyColumnsImagesInHeader(false);
            
            $result->SetHighlightRowAtHover(false);
            $result->SetWidth('');
            $this->CreateGridSearchControl($result);
            $this->CreateGridAdvancedSearchControl($result);
            $this->AddOperationsColumns($result);
            $this->AddFieldColumns($result);
            $this->AddSingleRecordViewColumns($result);
            $this->AddEditColumns($result);
            $this->AddInsertColumns($result);
            $this->AddPrintColumns($result);
            $this->AddExportColumns($result);
    
            $this->SetShowPageList(true);
            $this->SetHidePageListByDefault(false);
            $this->SetExportToExcelAvailable(false);
            $this->SetExportToWordAvailable(false);
            $this->SetExportToXmlAvailable(false);
            $this->SetExportToCsvAvailable(false);
            $this->SetExportToPdfAvailable(false);
            $this->SetPrinterFriendlyAvailable(false);
            $this->SetSimpleSearchAvailable(true);
            $this->SetAdvancedSearchAvailable(false);
            $this->SetFilterRowAvailable(false);
            $this->SetVisualEffectsEnabled(false);
            $this->SetShowTopPageNavigator(true);
            $this->SetShowBottomPageNavigator(true);
    
            //
            // Http Handlers
            //
            //
            // View column for picture field
            //
            $column = new TextViewColumn('picture', 'Picture', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_picture_handler_list', $column);
            GetApplication()->RegisterHTTPHandler($handler);
            //
            // View column for text1 field
            //
            $column = new TextViewColumn('text1', 'Text1', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_text1_handler_list', $column);
            GetApplication()->RegisterHTTPHandler($handler);
            //
            // View column for text2 field
            //
            $column = new TextViewColumn('text2', 'Text2', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_text2_handler_list', $column);
            GetApplication()->RegisterHTTPHandler($handler);
            //
            // View column for article_text field
            //
            $column = new TextViewColumn('article_text', 'Article Text', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_article_text_handler_list', $column);
            GetApplication()->RegisterHTTPHandler($handler);//
            // View column for picture field
            //
            $column = new TextViewColumn('picture', 'Picture', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_picture_handler_view', $column);
            GetApplication()->RegisterHTTPHandler($handler);
            //
            // View column for text1 field
            //
            $column = new TextViewColumn('text1', 'Text1', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_text1_handler_view', $column);
            GetApplication()->RegisterHTTPHandler($handler);
            //
            // View column for text2 field
            //
            $column = new TextViewColumn('text2', 'Text2', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_text2_handler_view', $column);
            GetApplication()->RegisterHTTPHandler($handler);
            //
            // View column for article_text field
            //
            $column = new TextViewColumn('article_text', 'Article Text', $this->dataset);
            $column->SetOrderable(true);
            $handler = new ShowTextBlobHandler($this->dataset, $this, 'main_articlesGrid_article_text_handler_view', $column);
            GetApplication()->RegisterHTTPHandler($handler);
            return $result;
        }
        
        public function OpenAdvancedSearchByDefault()
        {
            return false;
        }
    
        protected function DoGetGridHeader()
        {
            return '';
        }
    }



    try
    {
        $Page = new main_articlesPage("articles.php", "main_articles", GetCurrentUserGrantForDataSource("main.articles"), 'UTF-8');
        $Page->SetShortCaption('Articles');
        $Page->SetHeader(GetPagesHeader());
        $Page->SetFooter(GetPagesFooter());
        $Page->SetCaption('Main.Articles');
        $Page->SetRecordPermission(GetCurrentUserRecordPermissionsForDataSource("main.articles"));
        GetApplication()->SetEnableLessRunTimeCompile(GetEnableLessFilesRunTimeCompilation());
        GetApplication()->SetCanUserChangeOwnPassword(
            !function_exists('CanUserChangeOwnPassword') || CanUserChangeOwnPassword());
        GetApplication()->SetMainPage($Page);
        GetApplication()->Run();
    }
    catch(Exception $e)
    {
        ShowErrorPage($e->getMessage());
    }
	

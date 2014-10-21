Ext.Loader.setConfig({
    enabled: true
});
Ext.Loader.setPath('Ext.ux', '../assets/resources/ux');
Ext.require(['Ext.grid.*', 'Ext.toolbar.Paging', 'Ext.util.*', 'Ext.data.*', 'Ext.form.*', 'Ext.ux.form.SearchField', ]);
//构建数据集

Ext.override(Ext.grid.RowEditor, {
    addFieldsForColumn: function(column, initial) {
        var me = this,
        i, length, field;
        if (Ext.isArray(column)) {
            for (i = 0, length = column.length; i < length; i++) {
                me.addFieldsForColumn(column[i], initial);
            }
            return;
        }
        if (column.getEditor) {
            field = column.getEditor(null, {
                xtype: 'displayfield',
                getModelData: function() {
                    return null;
                }
            });
            if (column.align === 'right') {
                field.fieldStyle = 'text-align:right';
            }
            if (column.xtype === 'actioncolumn') {
                field.fieldCls += ' ' + Ext.baseCSSPrefix + 'form-action-col-field';
            }
            if (me.isVisible() && me.context) {
                if (field.is('displayfield')) {
                    me.renderColumnData(field, me.context.record, column);
                } else {
                    field.suspendEvents();
                    field.setValue(me.context.record.get(column.dataIndex));
                    field.resumeEvents();
                }
            }
            if (column.hidden) {
                me.onColumnHide(column);
            } else if (column.rendered && !initial) {
                me.onColumnShow(column);
            }

            // -- start edit
            me.mon(field, 'change', me.onFieldChange, me);
            // -- end edit
        }
    }
});
//重写RowEditor
Ext.onReady(function() {
    Ext.define('Admin', {
        extend: 'Ext.data.Model',
        fields: ['id', 'uid', 'nickname', 'email', 'desc', 'roles', 'pwd','privilege', {
            name: 'is_enabled',
            type: 'bool'
        }]
    });

    var store = Ext.create('Ext.data.Store', {
        model: 'Admin',
        pageSize: 10,
        autoLoad: true,
        proxy: {
            type: 'ajax',
            url: '/manage/admins.json',
            reader: {
                type: 'json',
                root: 'admins',
                totalProperty: 'totalCount'
            }
        }
    });
    //读取总数据完毕

    store.load({
        params: {
            start: 0,
            limit: 5
        }
    }); //一次读取5条记录

    var role_store = Ext.create('Ext.data.Store', {
        fields: ['id', 'name', 'is_enabled', 'remark', 'url', 'value'],
        autoLoad: true,
        // data: role_data
        proxy: {
            type: 'ajax',
            url: '/manage/roles.json',
            reader: {
                type: 'json',
                root: 'roles',
                totalProperty: 'totalCount'
            }
        }
    });
    //角色信息读取完毕

    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
        clicksToMoveEditor: 2,
        autoCancel: false,
        errorSummary: false,
        saveBtnText: '保存',
        cancelBtnText: '取消',
        errorsText: '错误',
        listeners: {
            'beforeedit': function() {
                var row = grid.getSelectionModel().getSelection();
                if (row.length) {
                    multiCombo.setValue(row[0].data.roles);
                    multiCombo.lastSelection = row[0].data.roles;
                    multiCombo.lastValue = row[0].data.roles;
                    multiCombo.setRawValue(roleRender(row[0].data.roles));
                }
            },
        }
    });
    //行编辑器

    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 2
    });
    //单元格编辑器

    var multiCombo = Ext.create('Ext.form.field.ComboBox', {
        multiSelect: true,
        displayField: 'name',
        valueField: 'value',
        id: 'multiCombo',
        store: role_store,
        editable: false,
        emptyText: '请选择职位',
        queryMode: 'local',
    });
    //多选combobox

    var pageSizeStore = new Ext.data.SimpleStore({
        fields: ['pageSizeValue', 'pageSizeItem'],
        data: [[5, 5], [10, 10], [15, 15], [20, 20], [50, 50]]
    });
    //自定义分页显示的数据

    var cmPageSize = new Ext.form.ComboBox({
        store: pageSizeStore,
        displayField: 'pageSizeItem',
        valueField: 'pageSizeValue',
        typeAhead: true,
        mode: 'local',
        triggerAction: 'all',
        emptyText: '10',
        width: 40,
        selectOnFocus: true
    });
    //创建选择每页数目的combox  

    var pagingToolbar = new Ext.PagingToolbar({
        emptyMsg: "没有数据",
        pageSize: 10,
        displayInfo: true,
        displayMsg: "显示从{0}条数据到{1}条数据，共{2}条数据",
        store: store,
    });
    //工具栏
    pagingToolbar.add('-', '每页', cmPageSize, '条记录');

    cmPageSize.on('change',
    function(e) {
        var myPageSize = e.getValue();
        pagingToolbar.pageSize = myPageSize;
        store.pageSize = myPageSize;
        store.load({
            params: {
                start: 0,
                limit: myPageSize
            }
        });
    });
    //监听选择显示页数的事件

function propWinShow(){
        var row = grid.getSelectionModel().getSelection(); //获取选择列
        var row_id = row[0].data.id;   
        Ext.Ajax.request({
             method: 'GET',
             url: '/manage/admins/' + row_id,
             success: function(response) {
                    var content = response.responseText;
                    var body = content.match(/<body>[\S\s]*?<\/body>/);
                    var win = new Ext.Window({
                        layout: 'fit',
                        width: 600,
                        height: 520,
                        closeAction: 'hide',
                        title: '查看详情',
                        constrain: 'true',
                        modal: true,
                        html:body,
                        buttons: [{
                            text: '关闭',
                            handler: function() {
                                win.hide();
                            }
                        }]
                    });
                    //模态窗口
                    win.show();
            },            
        });
    }

    var contextmenu = new Ext.menu.Menu({
        id: 'gridMenu',
        items: [{
            text: '查看详情',
            handler: function() {
                propWinShow();
            }
        }]
    });
    //右键菜单

    // function propSource() {
    //     var row = grid.getSelectionModel().getSelection(); //获取选择列
    //     var row_data = row[0].data;
    //     source = {
    //         'id': '',
    //         '账号': '',
    //         '昵称': '',
    //         '角色': '',
    //         '邮箱': '',
    //         '描述': '',
    //         '启用状态': ''
    //     };
    //     source.id = row_data.id;
    //     source.账号 = row_data.uid;
    //     source.昵称 = row_data.nickname;
    //     for (var k in row_data.roles) {
    //         if (k != 0) source.角色 += "," + row_data.roles[k].name;
    //         else source.角色 += row_data.roles[k].name;
    //     }
    //     source.邮箱 = row_data.email;
    //     source.描述 = row_data.desc;
    //     if (row_data.active) source.启用状态 = "启用";
    //     else source.启用状态 = "禁用";
    //     return source;
    // }
    //获取属性表格source，键名映射

    // var propGrid = new Ext.grid.PropertyGrid({
    //     autoHeight: true,
    //     viewConfig: {
    //         forceFit: true
    //     },
    //     source: {}
    // });
    // //属性表格

    // propGrid.on("beforeedit",
    // function(e) {
    //     e.cancel = true;
    //     return false;
    // });
    //关闭属性表格的编辑功能



    var tbar = new Ext.Toolbar({ 
        height: 50,
        items:  [{
            text: '添加管理员',
            itemId: 'insertBtn',
            //iconCls: 'admin-add',
            handler: function() {
                var r = Ext.create('Admin', {
                    uid: '',
                    nickname: '',
                    pwd: '',
                    email: '',
                    desc: '',
                    role: '',
                    active: true
                });
                store.insert(0, r);
                rowEditing.startEdit(0, 0);
                createAdmin = true;
                grid.columns[3].field.allowBlank = false;
            }
        },
        {
            itemId: 'removeBtn',
            text: '删除管理员',
            //iconCls: 'employee-remove',
            handler: function() {
                var sm = grid.getSelectionModel();
                var Selection = sm.getSelection();
                var ConfirmMessage = '确认要删除';
                for (var i = 0; i < Selection.length; i++) {
                    if (!i) ConfirmMessage += Selection[i].raw.nickname;
                    else ConfirmMessage += ', ' + Selection[i].raw.nickname;
                }
                ConfirmMessage += '吗?';
                rowEditing.cancelEdit();
                Ext.Msg.confirm('信息', ConfirmMessage,
                function(btn) {
                    if (btn == 'yes') {
                        var records = sm.getSelection();
                        for (var k in records) {
                            delteAdmin(records[k].get('id'));
                        }
                    }
                });
            },
            disabled: true
        },
        {
            text: '查看详情',
            itemId: 'viewBtn',
            handler: function() {
                var source = propSource();
                propGrid.setSource(source);
                win.show();
            }
        },
        {
            width: 250,
            fieldLabel: '搜索',
            style: 'float:right',
            labelWidth: 40,
            xtype: 'searchfield',
            store: store
        }]
    });
    //顶部工具栏

    var createAdmin = false; //创建管理员标签
    var c = $("meta[name='csrf-token']");
    var csrf_token = c[0].content;

    function roleRender(value) {
        var role_str = "";
        for (var k in value) {
            if (k == 0) role_str += value[k].name;
            else role_str += ',' + value[k].name;
        }
        return role_str;
    }
    //角色渲染方法

    var grid = Ext.create('Ext.grid.Panel', {
        id: 'grid',
        store: store,
        layout: 'fit',
        height: 500,
        title: '管理员列表',
        iconCls: 'icon-grid',
        margin: '10 10',
        forceFit: true,
        loadMask: true,
        renderTo: Ext.getBody(), 
        // selType: 'checkboxmodel',
        stateful: true,
        stateId: 'stateGrid',
        forceFit: true,
        columns: [{
            header: "ID",
            width: 20,
            dataIndex: 'id'
        },
        {
            header: "账号",
            dataIndex: 'uid',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                blankText: '请输入帐号'
            }
        },
        {
            header: "昵称",
            dataIndex: 'nickname',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                blankText: '请输入昵称'
            }
        },
        {
            header: "密码",
            dataIndex: 'pwd',
            editor: {
                xtype: 'textfield',
                //    allowBlank: false
                blankText: '请输入密码',
                minLength: '8',
                minLengthText: '密码长度不能小于8'
            },
            renderer: function() {
                return '*****';
            }
        },
        {
            header: "角色",
            dataIndex: 'roles',
            editor: multiCombo,
            renderer: function(value) {
                return roleRender(value);
            }
        },
        {
            header: "邮箱",
            dataIndex: 'email',
            editor: {
                //  allowBlank: false,
                vtype: 'email'
            }
        },
        {
            header: "描述",
            dataIndex: 'desc',
            editor: {
                xtype: 'textfield',
                // allowBlank: false
            }
        },
        {
            header: "是否启用",
            dataIndex: 'is_enabled',
            editor: {
                xtype: 'checkbox',
                allowBlank: false
            },
            renderer: function(value) {
                if (value) return "<span class='label label-success'>启用</span>";
                else return "<span class='label label-warning'>禁用</span>";
            }
        }],
        columnLines: true,
        tbar: tbar,
        bbar: pagingToolbar,
        plugins: [rowEditing, ],
        listeners: {
            'selectionchange': function(view, records) {
                grid.down('#removeBtn').setDisabled(!records.length);
            }
        }
    });

    grid.on("itemcontextmenu",
    function(view, record, item, index, e) {
        e.preventDefault();
        contextmenu.showAt(e.getXY());
    });

    grid.on('validateedit',
    function(editor, e) {
        e.record.data[e.field] = multiCombo.value;
        e.record.commit();
    });

    function jsonPost(post_data) {
        var params = [];

        params["authenticity_token"] = csrf_token;
        params["manage_admin[uid]"] = post_data.uid;
        params["manage_admin[nickname]"] = post_data.nickname;
        params["manage_admin[email]"] = post_data.email;
        params["manage_admin[desc]"] = post_data.desc;
        params["manage_admin[pwd]"] = post_data.pwd;
        params["manage_admin[is_enabled]"] = post_data.is_enabled ? 1 : 0;
        params["commit"] = "更新管理员信息";
        var params_post = '';
        for (var s in params) {
            params_post += s + '=' + encodeURIComponent(params[s]) + '&';
        }
        for (var k in post_data.roles) {
            if (k == 0) params_post += 'roles[]=' + post_data.roles[k].id;
            else params_post += '&' + 'roles[]=' + post_data.roles[k].id;
        }

        return params_post;
    }

    // 编辑完成后，提交更改
    grid.on('edit',
    function(editor, e) {
        var post_data = e.record.data;
        var admins_id = post_data.id;
        params_post = jsonPost(post_data);
        if (createAdmin) {
            Ext.Ajax.request({
                method: 'POST',
                url: '/manage/admins.json',
                success: function(response) {
                    Ext.Msg.alert('信息', '新建成功',
                    function() {
                        store.reload();
                    });
                },
                failure: function() {
                    Ext.Msg.alert('错误', '与后台联系时出错');
                    store.reload();
                },
                params: params_post
            });
        } else {
            Ext.Ajax.request({
                method: 'PATCH',
                url: '/manage/admins/' + admins_id + '.json',
                success: function(response) {
                    Ext.Msg.alert('信息', '保存成功',
                    function() {
                        store.reload();
                    });
                },
                failure: function() {
                    Ext.Msg.alert('错误', '与后台联系时出错');
                    store.reload();
                },
                params: params_post
            });
        }
        createAdmin = false;
        grid.columns[3].field.allowBlank = true;
    });

    //取消操作时重新加载数据
      grid.on('cancelEdit',function(editor,e){
        store.reload();
    });

    function delteAdmin(admins_id) {
        var params_delete = [];
        Ext.Ajax.request({
            method: 'DELETE',
            params: "authenticity_token=" + encodeURIComponent(csrf_token),
            url: '/manage/admins/' + admins_id + '.json',
            success: function(response) {
                Ext.Msg.alert('信息', '删除成功',
                function() {
                    store.reload();
                });
            },
            failure: function() {
                Ext.Msg.alert('错误', '与后台联系时出错');
                store.reload();
            },
        });
    }

});
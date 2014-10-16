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
        fields: ['id', 'stuid', 'name', 'email', 'phone', 'grade', 'url','pwd','avatar']
    });

    var store = Ext.create('Ext.data.Store', {
        model: 'Admin',
        pageSize: 10,
        autoLoad: true,
        proxy: {
            type: 'ajax',
            url: '/manage/students.json',
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

    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
        clicksToMoveEditor: 2,
        autoCancel: false,
        errorSummary: false,
        saveBtnText: '保存',
        cancelBtnText: '取消',
        errorsText: '错误',
    });
    //行编辑器

    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 2
    });
    //单元格编辑器

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

    var contextmenu = new Ext.menu.Menu({
        id: 'gridMenu',
        items: [{
            text: '查看详情',
            handler: function() {
                var source = propSource();
                propGrid.setSource(source);
                win.show();
            }
        }]
    });
    //右键菜单

    function propSource() {
        var row = grid.getSelectionModel().getSelection(); //获取选择列
        var row_data = row[0].data;
        source = {
            'id': '',
            '学号': '',
            '姓名': '',
            '邮箱': '',
            '年级': '',
            '电话': '',
            '密码': '',
            // '头像': ''
        };
        source.id = row_data.id;
        source.学号 = row_data.stuid;
        source.姓名 = row_data.name;
        source.邮箱 = row_data.email;
        source.年级 = row_data.grade;
        source.电话 = row_data.phone;
        source.密码 = "******";
        // source.头像 = "<img width='50px' src='" + row_data.avatar + "'>";
        return source;
    }
    //获取属性表格source，键名映射

    var propGrid = new Ext.grid.PropertyGrid({
        autoHeight: true,
        viewConfig: {
            forceFit: true
        },
        source: {}
    });
    //属性表格

    propGrid.on("beforeedit",
    function(e) {
        e.cancel = true;
        return false;
    });
    //关闭属性表格的编辑功能

    var win = new Ext.Window({
        layout: 'fit',
        width: 400,
        height: 400,
        closeAction: 'hide',
        title: '查看详情',
        constrain: 'true',
        modal: true,
        items: [propGrid],

        buttons: [{
            text: '关闭',
            handler: function() {
                win.hide();
            }
        }]
    });
    //模态窗口
    var tbar = new Ext.Toolbar({ 
        height: 50,
        items:  [{
            text: '添加学生',
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
            text: '删除学生',
            //iconCls: 'employee-remove',
            handler: function() {
                var sm = grid.getSelectionModel();
                var Selection = sm.getSelection();
                var ConfirmMessage = '确认要删除';
                for (var i = 0; i < Selection.length; i++) {
                    if (!i) ConfirmMessage += Selection[i].raw.name;
                    else ConfirmMessage += ', ' + Selection[i].raw.name;
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
            width: 200,
            fieldLabel: '搜索',
            style: 'float:right',
            labelWidth: 40,
            xtype: 'searchfield',
            store: store

        }]
    });
    //顶部工具栏

    var fileInput = new Ext.form.TextField({
              inputType:'file'
    });
    //上传input

    var createAdmin = false; //创建管理员标签
    var c = $("meta[name='csrf-token']");
    var csrf_token = c[0].content;

    var grid = Ext.create('Ext.grid.Panel', {
        id: 'grid',
        store: store,
        // selType: 'checkboxmodel',
        stateful: true,
        stateId: 'stateGrid',
        layout: 'fit',
        height: 500,
        title: '学生名单',
        iconCls: 'icon-grid',
        margin: '10 10',
        forceFit: true,
        loadMask: true,
        renderTo: Ext.getBody(),
        columns: [{
            header: "ID",
            dataIndex: 'id'

        },
        {
            header:"头像",
            dataIndex: 'avatar',
            // align: 'center',
            renderer: function(value){
                    if(value)
                        return "<img width='30px' src='" + value + "'/>"; 
                    else
                        return "<img width='30px' src='/assets/user-thumb.png'>";
            },
               editor: fileInput
        },
        {
            header: "学号",
            dataIndex: 'stuid',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                blankText: '请输入学号'
            }
        },
        {
            header: "姓名",
            dataIndex: 'name',
            editor: {
                xtype: 'textfield',
                allowBlank: false,
                blankText: '请输入姓名'
            }
        },
        {
            header:'密码',
            dataIndex:'pwd',
            editor: {
                xtype: 'textfield',
                allowBlank: true,
                blankText: '请输入密码'
            },
            renderer: function(){
                    return '******';
            }
        },
        {
            header: "电话",
            dataIndex: 'phone',
            editor: {
                xtype: 'textfield',
                //    allowBlank: false
            },
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
            header: "年级",
            dataIndex: 'grade',
            editor: {
                xtype: 'numberfield',
                // allowBlank: false
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

    // grid.on("itemcontextmenu",
    // function(view, record, item, index, e) {
    //     e.preventDefault();
    //     contextmenu.showAt(e.getXY());
    // });

    function jsonPost(post_data) {
        var params = [];

        params["authenticity_token"] = csrf_token;
        params["manage_student[stuid]"] = post_data.stuid;
        params["manage_student[name]"] = post_data.name;
        params["manage_student[email]"] = post_data.email;
        params["manage_student[phone]"] = post_data.phone;
        params["manage_student[pwd]"] = post_data.pwd;
        params["manage_student[grade]"] = post_data.grade;
        params["commit"] = "更新学生信息";
        var params_post = '';
        for (var s in params) {
            params_post += s + '=' + encodeURIComponent(params[s]) + '&';
        }
        return params_post;
    }

    // 编辑完成后，提交更改
    grid.on('edit',
    function(editor, e) {
        var post_data = e.record.data;
        console.log(fileInput.value);
        var students_id = post_data.id;
        params_post = jsonPost(post_data);
        if (createAdmin) {
            Ext.Ajax.request({
                method: 'POST',
                url: '/manage/students.json',
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
                url: '/manage/students/' + students_id + '.json',
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
      
    function delteAdmin(students_id) {
        var params_delete = [];
        Ext.Ajax.request({
            method: 'DELETE',
            params: "authenticity_token=" + encodeURIComponent(csrf_token),
            url: '/manage/students/' + students_id + '.json',
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
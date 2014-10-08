Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath('Ext.ux', '../assets/resources/ux');
Ext.require([
    'Ext.grid.*',
    'Ext.toolbar.Paging',
    'Ext.util.*',
    'Ext.data.*',
    'Ext.form.*',
    'Ext.ux.form.SearchField',
]);
//构建数据集

Ext.onReady(function() {
    Ext.define('Admin', {
        extend: 'Ext.data.Model',
        fields: [
            'id',
            'uid',
            'nickname',
            'email',
            'desc',
            'roles',
            { name: 'is_enabled', type: 'bool' }
        ]
    });

    var store= Ext.create('Ext.data.Store', {
        model: 'Admin',
        pageSize:5,
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

    var role_data = [
        {
            "value": "1",
            "role": "role1"
        },
        {
            "value": "2",
            "role": "role2"
        },
        {
            "value": "3",
            "role": "role3"
        }
    ];

    store.load({params:{start:0,limit:5}});//一次读取5条记录

    var role_store = Ext.create('Ext.data.Store', {
        fields: ['value','role'],
        autoLoad: true,
        data: role_data
//        proxy: {
//            type: 'ajax',
//            url: 'role.json',
//            reader: {
//                type: 'json',
//                totalProperty: 'totalCount'
//            }
//        }
    });
    //角色信息读取完毕

    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
        clicksToMoveEditor: 2,
        autoCancel: false
    });
    //行编辑器

    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing',{
        clicksToEdit:2
    });
    //单元格编辑器

    var multiCombo = Ext.create('Ext.form.field.ComboBox', {
        multiSelect: true,
        displayField: 'role',
        valueField: 'value',
        id: 'multiCombo',
        store: role_store,
        editable: false,
        emptyText: '请选择职位',
        queryMode: 'local',
    });
    //多选combobox

    var pagingToolbar = new Ext.PagingToolbar
    ({
        emptyMsg:"没有数据",
        displayInfo:true,
        displayMsg:"显示从{0}条数据到{1}条数据，共{2}条数据",
        store:store,
        pageSize:5
    });
    //工具栏

    var contextmenu = new Ext.menu.Menu({
        id: 'gridMenu',
        items: [{
            text: '查看详情',
            handler: function(){
                var source = propSource();
                propGrid.setSource(source);
                win.show();
            }
        }]
    });
    //右键菜单

    function propSource()
    {
        var row = grid.getSelectionModel().getSelection();//获取选择列
        var row_data = row[0].data;
        source = {
            'id': '',
            '账号': '',
            '昵称': '',
            '角色': '',
            '邮箱': '',
            '描述': '',
            '启用状态': ''
        };
        source.id = row_data.id;
        source.账号 = row_data.uid;
        source.昵称 = row_data.nickname;
        for(var k in row_data.roles){
            var index = role_store.find("value",row_data.roles[k]);
            var record =  role_store.getAt(index);
            if(k != 0)
                source.角色 += "," + record.get("role");
            else
                source.角色 += record.get("role");
        }
        source.邮箱 = row_data.email;
        source.描述 = row_data.desc;
        if(row_data.active)
            source.启用状态 = "启用";
        else
            source.启用状态 = "禁用";
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

    propGrid.on("beforeedit",function(e){
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

        buttons:[
            {
                text: '关闭',
                handler: function () {
                    win.hide();
                }
            }
        ]
    });
    //模态窗口



    var grid = Ext.create('Ext.grid.Panel', {
        id: 'grid',
        store: store,
        selType: 'checkboxmodel',
        stateful: true,
        stateId: 'stateGrid',
        columns: [
        {
            header: "ID",
            dataIndex: 'id'

        },{
            header: "账号",
            dataIndex: 'uid',
            editor: {
                xtype: 'textfield',
                allowBlank: false
            }            
        },{
            header: "昵称",
            dataIndex: 'nickname',
            editor: {
                xtype: 'textfield',
                allowBlank: false
            }            
        },{
            header: "角色",
            dataIndex: 'roles',
            editor:multiCombo,
            renderer: function(value){
                var roles = "";
                for(var k in value){
                    var index = role_store.find("value",value[k]);
                    var record =  role_store.getAt(index);
                    if(k != 0)
                        roles += "," + record.get("role");
                    else
                        roles += record.get("role");
                }
                return roles;
            }
        },{
            header: "邮箱",
            dataIndex: 'email',
            editor: {
                allowBlank: false,
                vtype: 'email'
            }
        },{
            header: "描述",
            dataIndex: 'desc',
            editor: {
                xtype: 'textfield',
                allowBlank: false
            }            
        },{
            header: "是否启用",
            dataIndex: 'is_enabled',
            editor: {
                xtype: 'checkbox',
                allowBlank: false
            },
            renderer: function(value){
                if(value)
                    return "启用";
                else
                    return "禁用";
            }
        }],
        columnLines: true,

        width: 1000,
        height: 500,
        frame: true,
        title: '管理员列表',
        iconCls: 'icon-grid',
        margin: '10 10',
        forceFit: true,
        loadMask: true,
        renderTo: Ext.getBody(),
        tbar: [{
            text: '添加管理员',
            itemId:'insertBtn',
            //iconCls: 'admin-add',
            handler : function() {
                rowEditing.cancelEdit();
                // Create a model instance
                var r = Ext.create('Admin', {
                    uid: '此处填写用户名',
                    nickname: '此处填写昵称',
                    email: 'example@example.com',
                    desc: '此处添加新描述',
                    role: '',
                    active: true
                });
                store.insert(0, r);
                //rowEditing.startEdit(0, 0);
            }
        }, {
            itemId: 'removeBtn',
            text: '删除管理员',
            //iconCls: 'employee-remove',
            handler: function() {
                var sm = grid.getSelectionModel();
                var Selection = sm.getSelection();
                var ConfirmMessage = '确认要删除';
                for(var i = 0; i< Selection.length; i++){
                    if(!i)
                        ConfirmMessage += Selection[i].raw.nickname;
                    else
                        ConfirmMessage += ', ' + Selection[i].raw.nickname;
                }
                ConfirmMessage += '吗?';
                rowEditing.cancelEdit();
                Ext.Msg.confirm('信息',ConfirmMessage,function(btn){
                   if(btn == 'yes'){

                       store.remove(sm.getSelection());
                       grid.view.refresh();
                       if (store.getCount() > 0) {
                           sm.select(0);
                       }
                   }
                });
            },
            disabled: true
        },{
            text: '保存修改',
            itemId: 'saveBtn',
            handler: function(){
                var m = store.getModifiedRecords().slice(0);
                var jsonArray = [];
                Ext.each(m, function(item){
                    jsonArray.push(item.data);
                });
                console.log(jsonArray);
                Ext.Ajax.request({
                    method: 'POST',
                    url: '/manage/admins.json',
                    success: function(response){
                        Ext.Msg.alert('信息','保存成功',function(){
                            console.log(response.responseText);
                            store.reload();
                        });
                    },
                    failure: function(){
                        Ext.Msg.alert('错误','与后台联系时出错');
                    },
                    params:'data='+encodeURIComponent(Ext.encode(jsonArray))
                });
            }
        },{
            text: '查看详情',
            itemId: 'viewBtn',
            handler: function(){
                var source = propSource();
                propGrid.setSource(source);
                win.show();
            }
        },{
             width: 200,
             fieldLabel: '搜索',
             style: 'float:right',
             labelWidth: 30,
             xtype: 'searchfield',
             store: store

    }],
        bbar:pagingToolbar,
        plugins: [
            cellEditing,
        ],
//
        listeners: {
            'selectionchange': function(view, records) {
                grid.down('#removeBtn').setDisabled(!records.length);
            }
        }
    });

    grid.on("itemcontextmenu",function(view, record, item, index ,e){
        e.preventDefault();
        contextmenu.showAt(e.getXY());
    });
});
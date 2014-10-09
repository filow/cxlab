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
            'pwd',
            { name: 'is_enabled', type: 'bool' }
        ]
    });

    var store= Ext.create('Ext.data.Store', {
        model: 'Admin',
       	pageSize:5,
        autoLoad:true,
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
    store.load({params:{start:0,limit:5}});//一次读取5条记录

    var role_store = Ext.create('Ext.data.Store', {
        fields: ['id','name','is_enabled','remark','url','value'],
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
        autoCancel: false
    });
    //行编辑器

    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing',{
        clicksToEdit:2
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
        listeners: {
        	'select': function(){
       // 		console.log(multiCombo.value);
        	}
        }
    });
    //多选combobox

    var pagingToolbar = new Ext.PagingToolbar
    ({
        emptyMsg:"没有数据",
        displayInfo:true,
        displayMsg:"显示从{0}条数据到{1}条数据，共{2}条数据",
        store:store,
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
        	header: "密码",
        	dataIndex: 'pwd',
            editor: {
                xtype: 'textfield',
                //allowBlank: false
            },
            renderer: function(){
            	return '*****';
            }       	
        },{
            header: "角色",
            dataIndex: 'roles',
            editor:multiCombo,
            renderer: function(value){
            	var role_str = "";
            	for(var k in value){
            		if(k == 0)
            			role_str += value[k].name;
            		else 
            			role_str += ',' + value[k].name;
            	}
            	return role_str;
            }
        },{
            header: "邮箱",
            dataIndex: 'email',
            editor: {
              //  allowBlank: false,
                vtype: 'email'
            }
        },{
            header: "描述",
            dataIndex: 'desc',
            editor: {
                xtype: 'textfield',
               // allowBlank: false
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
                //rowEditing.cancelEdit();
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
                rowEditing.startEdit(0, 0);
                grid.on('edit', function(editor, e) {  
                	console.log(e.record.data);
                });
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
            rowEditing,
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

    grid.on('validateedit', function(editor, e) {
    	e.record.data[e.field] = multiCombo.value;
    	e.record.commit();
	});

    // 编辑完成后，提交更改
	grid.on('edit', function(editor, e) {  
    	var post_data = e.record.data;
    	var c = $("meta[name='csrf-token']");
		var csrf_token = c[0].content;
		var params = [];
		var admins_id = post_data.id;
		params["_method"] = 'patch';
		params["authenticity_token"] = csrf_token;
        params["manage_admin[uid]"] = post_data.uid; 
        params["manage_admin[nickname]"] = post_data.nickname; 
        params["manage_admin[email]"] = post_data.email; 
        params["manage_admin[desc]"] = post_data.desc; 
        params["manage_admin[pwd]"] = post_data.pwd; 
        params["manage_admin[is_enabled]"] = post_data.is_enabled? 1:0; 
        params["commit"] = "更新管理员信息";

        var params_post = '';
        for(var s in params){
        	params_post += s + '=' + encodeURIComponent(params[s]) + '&';
        }
        for(var k in post_data.roles){
        	if(k == 0)
        		params_post += 'roles[]=' + post_data.roles[k].id;
        	else
        		params_post += '&' + 'roles[]=' + post_data.roles[k].id; 
    		console.log(post_data.roles[k]);    	
        }

        console.log(params_post);

        Ext.Ajax.request({
	        method: 'POST',
            url: '/manage/admins/' + admins_id ,
            success: function(response){
                Ext.Msg.alert('信息','保存成功',function(){
                    console.log(response.responseText);
                    store.reload();
                });
            },
            failure: function(){
                Ext.Msg.alert('错误','与后台联系时出错');
                console.log(params);
                store.reload();
            },
            params: params_post
        });
    });

	//取消操作时重新加载数据
	grid.on('cancelEdit',function(editor,e){
		store.reload();
	});
});
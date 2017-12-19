package com.xiaomu.data {
	
    /**
	 * 角色数据
	 * */
	public class Role {
		
		public var id: String            // 角色ID
		public var name: String          // 角色名称
		public var icon: String          // 角色图标
		public var type: String          // 角色类型   可以自己扩展如 'bg' 'music'
		public var source: *             // 角色源数据 泛型-可以为Array 可以为String
		
	}
}
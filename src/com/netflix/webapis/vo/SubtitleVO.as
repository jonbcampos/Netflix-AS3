package com.netflix.webapis.vo
{
	[RemoteClass(alias="com.netflix.webapis.vo.SubtitleVO")]
	public class SubtitleVO extends CategoryItemVO
	{
		public function SubtitleVO()
		{
		}
		
		public var primary:Boolean;
		public var code:String;
	}
}
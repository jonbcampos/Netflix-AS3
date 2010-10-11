package com.netflix.webapis.events
{
	import com.netflix.webapis.vo.LinkItem;
	
	import flash.events.Event;
	
	public class ExpansionEvent extends Event
	{
		public static const CAST_CHANGE:String = "castChange";
		public static const FORMATS_CHANGE:String = "formatsChange";
		public static const SCREEN_FORMATS_CHANGE:String = "screenFormatsChange";
		public static const SIMILARS_CHANGE:String = "similarsChange";
		public static const SYNOPSIS_CHANGE:String = "synopsisChange";
		public static const DIRECTORS_CHANGE:String = "directorsChange";
		public static const AWARDS_CHANGE:String = "awardsChange";
		public static const LANGUAGES_AND_AUDIO_CHANGE:String = "languagesAndAudioChange";
		public static const DISCS_CHANGE:String = "discsChange";
		public static const EPISODES_CHANGE:String = "episodesChange";
		public static const SEASONS_CHANGE:String = "seasonsChange";
		public static const FILMOGRAPHY_CHANGE:String = "filmographyChange";
		public static const BONUS_MATERIALS_CHANGE:String = "bonusMaterialsChange";
		
		public static const TITLE_STATES_CHANGE:String = "titleStatesChange";
		
		private var _value:Object;
		public function get value():Object
		{
			return _value;
		}
		
		private var _expansion:LinkItem;
		public function get expansion():LinkItem
		{
			return _expansion;
		}
		
		public function ExpansionEvent(type:String, value:Object, expansion:LinkItem, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_value = value;
			_expansion = expansion;
		}
		
		override public function clone():Event
		{
			return new ExpansionEvent(type, value, expansion, bubbles, cancelable);
		}
	}
}
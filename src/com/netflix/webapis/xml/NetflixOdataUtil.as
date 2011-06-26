package com.netflix.webapis.xml
{
	import com.netflix.webapis.vo.CatalogItemVO;
	import com.netflix.webapis.vo.FormatAvailabilityVO;
	import com.netflix.webapis.vo.LinkItemVO;

	public class NetflixOdataUtil
	{
		//---------------------------------------------------------------------
		//
		//  Constants
		//
		//---------------------------------------------------------------------
		public static const ID:String = "http://www.w3.org/2005/Atom::id";
		public static const UPDATED:String = "http://www.w3.org/2005/Atom::updated";
		public static const PROPERTIES:String = "http://schemas.microsoft.com/ado/2007/08/dataservices/metadata::properties";
		public static const LINK : String = "http://www.w3.org/2005/Atom::link";
		public static const CATEGORY:String = "http://www.w3.org/2005/Atom::category";
		
		public static const COUNT:String = "http://schemas.microsoft.com/ado/2007/08/dataservices/metadata::count";
		//---------------------------------------------------------------------
		//
		//  Private
		//
		//---------------------------------------------------------------------
		private static const SYNOPSIS:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Synopsis";
		private static const SYNOPSIS_SHORT:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::ShortSynopsis";
		private static const AVERAGE_RATING:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::AverageRating";
		private static const RELEASE_YEAR:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::ReleaseYear";
		private static const NETFLIX_ID:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::NetflixApiId";
		private static const RUNTIME:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Runtime";
		private static const RATING:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Rating";
		private static const SHORT_NAME:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::ShortName";
		private static const NAME:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Name";
		private static const WEBSITE:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Url";
		private static const DATE_MODIFIED:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::DateModified";
		private static const TINY_URL:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::TinyUrl";
		
		private static const BOX_ART:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::BoxArt";
		private static const SMALL_URL:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::SmallUrl";
		private static const MEDIUM_URL:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::MediumUrl";
		private static const LARGE_URL:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::LargeUrl";
		private static const HIGH_DEFINITION_URL:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::HighDefinitionUrl";
		
		private static const INSTANT:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Instant";
		private static const DVD:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Dvd";
		private static const BLURAY:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::BluRay";
		
		private static const AVAILABLE:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Available";
		private static const AVAILABLE_FROM:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::AvailableFrom";
		private static const AVAILABLE_TO:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::AvailableTo";
		private static const HIGH_DEFINITION_AVAILABLE:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::HighDefinitionAvailable";
		
		//---------------------------------------------------------------------
		//
		//  Methods
		//
		//---------------------------------------------------------------------
		public static function handleOdataToCatalogItemModel(xml:XML, item:CatalogItemVO=null):CatalogItemVO
		{
			if(!item)
				item = new CatalogItemVO();
			
			var resultNode:XML;
			var child:XML;
			var subChild:XML;
			var subChildName:String;
			item.categories = [];
			item.links = [];
			
			var format:FormatAvailabilityVO;
			
			for each (resultNode in xml.children())
			{
				var nodeType:String = String(resultNode.name());
				switch(nodeType)
				{
					case ID:
						item.id = handleStringNode(resultNode);
						break;
					case UPDATED:
						item.lastUpdated = handleDateNode(resultNode);
						break;
					case PROPERTIES:
						var children:XMLList = resultNode.children();
						for each(child in children)
						{
							var childName:String = String(child.name());
							switch(childName)
							{
								case SYNOPSIS:
									item.synopsisString = handleStringNode(child);
									break;
								case SYNOPSIS_SHORT:
									item.synopsisShortString = handleStringNode(child);
									break;
								case AVERAGE_RATING:
									item.averageRating = handleNumberNode(child);
									break;
								case RELEASE_YEAR:
									item.releaseYear = handleNumberNode(child);
									break;
								case NETFLIX_ID:
									item.netflixId = handleStringNode(child);
									break;
								case RUNTIME:
									item.runtime = handleNumberNode(child);
									break;
								case RATING:
									item.rating = handleStringNode(child);
									break;
								case UPDATED:
									item.lastUpdated = handleDateNode(child);
									break;
								case WEBSITE:
									var webPage:LinkItemVO = new LinkItemVO();
									webPage.url = handleStringNode(child);
									webPage.title = "Webpage";
									item.webPage = webPage;
									break;
								case SHORT_NAME:
									item.titleShort = handleStringNode(child);
									break;
								case NAME:
									item.titleRegular = handleStringNode(child);
									break;
								case TINY_URL:
									var tinyUrl:LinkItemVO = new LinkItemVO();
									tinyUrl.url = handleStringNode(child);
									tinyUrl.title = "TinyUrl";
									item.tinyUrl = tinyUrl;
									break;
								//box art
								case BOX_ART:
									for each(subChild in child.children())
									{
										subChildName = String(subChild.name());
										switch(subChildName)
										{
											case SMALL_URL:
												var smallUrl:String = handleStringNode(subChild);
												item.boxArtTiny = smallUrl;
												item.boxArt88 = smallUrl;
												break;
											case MEDIUM_URL:
												var mediumUrl:String = handleStringNode(subChild);
												item.boxArtSmall = mediumUrl;
												item.boxArt124 = mediumUrl;
												break;
											case LARGE_URL:
												var largeUrl:String = handleStringNode(subChild);
												item.boxArtLarge = largeUrl;
												item.boxArt150 = largeUrl;
												break;
										}
									}
									break;
								case INSTANT:
									if(!item.formatsList)
										item.formatsList = [];
									format = handleDeliveryFormat(child);
									
									if(format)
									{
										item.formatsList.push(format);
										
										if(format.availableFrom)
											item.isInstant = true;
									}
									break;
								case DVD:
									if(!item.formatsList)
										item.formatsList = [];
									format = handleDeliveryFormat(child);
									
									if(format)
									{
										item.formatsList.push(format);
										
										if(format.availableFrom)
											item.isDvd = true;
									}
									break;
								case BLURAY:
									if(!item.formatsList)
										item.formatsList = [];
									format = handleDeliveryFormat(child);
									
									if(format)
									{
										item.formatsList.push(format);
										
										if(format.availableFrom)
											item.isBluray = true;
									}
									break;
							}
						}
						break;
				}
			}
			
			return item;
		}
		
		public static function handleStringNode(xml:XML):String
		{
			return xml.valueOf().toString();
		}
		
		public static function handleNumberNode(xml:XML):Number
		{
			return Number(xml.valueOf());
		}
		
		public static function handleUintNode(xml:XML):uint
		{
			return uint(xml.valueOf());
		}
		
		public static function handleintNode(xml:XML):int
		{
			return int(xml.valueOf());
		}
		
		public static function handleBooleanNode(xml:XML):Boolean
		{
			return (xml.valueOf()=="true")?true:false;
		}
		
		public static function handleDateNode(xml:XML):Date
		{
			var dateString:String = xml.valueOf().toString();
			//empty check
			if(dateString=="")
				return null;
			var cleanString:String = dateString.replace("T"," ");
			cleanString = cleanString.replace("Z", "");
			cleanString = cleanString.replace(/-/g, "/");
			return new Date(cleanString);
		}
		
		public static function handleDeliveryFormat(xml:XML):FormatAvailabilityVO
		{
			var resultNode:XML;
			var format:FormatAvailabilityVO = new FormatAvailabilityVO();
			
			for each (resultNode in xml.children())
			{
				var nodeType:String = String(resultNode.name());
				switch(nodeType)
				{
					case AVAILABLE_FROM:
						format.availableFrom = handleDateNode(resultNode);
						break;
					case AVAILABLE_TO:
						format.availableUntil = handleDateNode(resultNode);
						break;
					case HIGH_DEFINITION_AVAILABLE:
						//format.highDefinitionAvailable = handleBooleanNode(resultNode);
						break;
				}
			}
			return format;
		}
		
		public static function handleCount(xml:XML):int
		{
			var resultNode:XML;
			
			for each (resultNode in xml.children())
			{
				var nodeType:String = String(resultNode.name());
				switch(nodeType)
				{
					case COUNT:
						return handleintNode(resultNode);
						break;
				}
			}
			return 0;
		}
	}
}
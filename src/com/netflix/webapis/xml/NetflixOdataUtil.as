package com.netflix.webapis.xml
{
	import com.netflix.webapis.models.CatalogItemModel;
	import com.netflix.webapis.vo.FormatAvailability;

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
		private static const AVERAGE_RATING:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::AverageRating";
		private static const RELEASE_YEAR:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::ReleaseYear";
		private static const NETFLIX_ID:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::NetflixApiId";
		private static const RUNTIME:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Runtime";
		private static const RATING:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Rating";
		private static const SHORT_NAME:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::ShortName";
		private static const NAME:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::Name";
		private static const WEBSITE:String = "http://schemas.microsoft.com/ado/2007/08/dataservices::WebsiteUrl";
		
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
		public static function handleOdataToCatalogItemModel(xml:XML, model:CatalogItemModel=null):CatalogItemModel
		{
			if(!model)
				model = new CatalogItemModel();
			
			var resultNode:XML;
			var child:XML;
			var subChild:XML;
			var subChildName:String;
			model.categories = [];
			model.links = [];
			
			var format:FormatAvailability;
			
			for each (resultNode in xml.children())
			{
				var nodeType:String = String(resultNode.name());
				switch(nodeType)
				{
					case ID:
						model.id = handleStringNode(resultNode);
						break;
					case UPDATED:
						model.lastUpdated = handleDateNode(resultNode);
						break;
					case PROPERTIES:
						for each(child in resultNode.children())
						{
							var childName:String = String(child.name());
							switch(childName)
							{
								case SYNOPSIS:
									model.synopsisString = handleStringNode(child);
									break;
								case AVERAGE_RATING:
									model.averageRating = handleNumberNode(child);
									break;
								case RELEASE_YEAR:
									model.releaseYear = handleNumberNode(child);
									break;
								case NETFLIX_ID:
									model.netflixId = handleStringNode(child);
									break;
								case RUNTIME:
									model.runtime = handleNumberNode(child);
									break;
								case RATING:
									model.rating = handleStringNode(child);
									break;
								case SHORT_NAME:
									model.titleShort = handleStringNode(child);
									break;
								case NAME:
									model.titleRegular = handleStringNode(child);
									break;
								//box art
								case BOX_ART:
									for each(subChild in child.children())
									{
										subChildName = String(subChild.name());
										switch(subChildName)
										{
											case SMALL_URL:
												model.boxArtSmall = handleStringNode(subChild);
												break;
											case MEDIUM_URL:
												model.boxArtMedium = handleStringNode(subChild);
												break;
											case LARGE_URL:
												model.boxArtLarge = handleStringNode(subChild);
												break;
										}
									}
									break;
								case INSTANT:
									if(!model.formatsList)
										model.formatsList = [];
									format = handleDeliveryFormat(child);
									
									if(format)
									{
										model.formatsList.push(format);
										
										if(format.availableFromAvailable)
											model.isInstant = true;
									}
									break;
								case DVD:
									if(!model.formatsList)
										model.formatsList = [];
									format = handleDeliveryFormat(child);
									
									if(format)
									{
										model.formatsList.push(format);
										
										if(format.availableFromAvailable)
											model.isDvd = true;
									}
									break;
								case BLURAY:
									if(!model.formatsList)
										model.formatsList = [];
									format = handleDeliveryFormat(child);
									
									if(format)
									{
										model.formatsList.push(format);
										
										if(format.availableFromAvailable)
											model.isBluray = true;
									}
									break;
							}
						}
						break;
				}
			}
			
			return model;
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
		
		public static function handleDeliveryFormat(xml:XML):FormatAvailability
		{
			var resultNode:XML;
			var format:FormatAvailability = new FormatAvailability();
			
			for each (resultNode in xml.children())
			{
				var nodeType:String = String(resultNode.name());
				switch(nodeType)
				{
					case AVAILABLE_FROM:
						format.availableFrom = handleDateNode(resultNode);
						if(format.availableFrom)
							format.availableFromAvailable = true;
						break;
					case AVAILABLE_TO:
						format.availableUntil = handleDateNode(resultNode);
						if(format.availableUntil)
							format.availableUntilAvailable = true;
						break;
					case HIGH_DEFINITION_AVAILABLE:
						format.highDefinitionAvailable = handleBooleanNode(resultNode);
						break;
				}
			}
			return format;
		}
		
		public static function handleCount(xml:XML):uint
		{
			var resultNode:XML;
			
			for each (resultNode in xml.children())
			{
				var nodeType:String = String(resultNode.name());
				switch(nodeType)
				{
					case COUNT:
						return handleUintNode(resultNode);
						break;
				}
			}
			return 0;
		}
	}
}
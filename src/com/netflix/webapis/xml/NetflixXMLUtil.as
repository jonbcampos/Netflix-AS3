/**
 * Copyright (c) 2009 Netflix-AS3_API Contributors.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of 
 * this software and associated documentation files (the "Software"), to deal in 
 * the Software without restriction, including without limitation the rights to 
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
 * of the Software, and to permit persons to whom the Software is furnished to do 
 * so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all 
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE. 
 * */
package com.netflix.webapis.xml
{
	import com.netflix.webapis.services.ServiceStorage;
	import com.netflix.webapis.vo.AtHomeItemVO;
	import com.netflix.webapis.vo.AwardNomineeVO;
	import com.netflix.webapis.vo.AwardWinnerVO;
	import com.netflix.webapis.vo.CatalogItemVO;
	import com.netflix.webapis.vo.CategoryItemVO;
	import com.netflix.webapis.vo.FilmographyItemVO;
	import com.netflix.webapis.vo.FormatAvailabilityVO;
	import com.netflix.webapis.vo.LangaugeFormatVO;
	import com.netflix.webapis.vo.LinkItemVO;
	import com.netflix.webapis.vo.PersonVO;
	import com.netflix.webapis.vo.QueueItemVO;
	import com.netflix.webapis.vo.RatingsItemVO;
	import com.netflix.webapis.vo.RentalHistoryItemVO;
	import com.netflix.webapis.vo.ScreenFormatVO;
	import com.netflix.webapis.vo.SubtitleVO;
	import com.netflix.webapis.vo.TitleFormatVO;
	import com.netflix.webapis.vo.TitleStateItemVO;
	import com.netflix.webapis.vo.TitleStateVO;
	
	/**
	 * Utility file to parse XML results from Netflix API.
	 * @author brianburck
	 * 
	 */
	public class NetflixXMLUtil
	{
		public static const ID:String = "id";
		public static const CATALOG_TITLE:String = "catalog_title";
		public static const TITLE:String = "title";
		public static const BOX_ART:String = "box_art";
		public static const LINK : String = "link";
		public static const FORMAT : String = "format";
		public static const RELEASE_YEAR:String = "release_year";
		public static const CATEGORY:String = "category";
		public static const RUNTIME:String = "runtime";
		public static const AVERAGE_RATING:String = "average_rating";
		public static const USER_RATING:String = "user_rating";
		public static const PREDICTED_RATING:String = "predicted_rating";
		public static const SEASON_NUMBER:String = "season_number";
		public static const SEQUENCE:String = "sequence";
		
		public static const SHIPPED_DATE:String = "shipped_date";
		public static const ESTIMATED_ARRIVAL_DATE:String = "estimated_arrival_date";
		public static const RETURNED_DATE:String = "returned_date";
		public static const WATCHED_DATE:String = "watched_date";
		public static const VIEWED_TIME:String = "viewed_time";
		
		
		public static const PERSON:String = "person";
		public static const NAME:String = "name";
		public static const BIO:String = "bio";
		
		public static const SYNOPSIS_ATTR:String = "synopsis";
		public static const CAST_ATTR:String = "cast";
		public static const DIRECTOR_ATTR:String = "directors";
		public static const FORMATS_ATTR:String = "formats";
		public static const SCREEN_FORMATS_ATTR:String = "screen formats";
		public static const AUDIO_ATTR:String = "languages and audio";
		public static const SEASONS_ATTR:String = "seasons";
		public static const EPISODES_ATTR:String = "episodes";
		public static const SIMILARS_ATTR:String = "similars";
		public static const OFFICIAL_SITE_ATTR:String = "official webpage";
		public static const NETFLIX_PAGE_ATTR:String = "web page";
		public static const TINY_URL_ATTR:String = "Tiny URL";
		public static const FILMOGRAPHY_ATTR:String = "filmography";
		public static const DISCS_ATTR:String = "discs";
		public static const AWARDS_ATTR:String = "awards";
		public static const ALTERNATE_ATTR:String = "alternate";
		
		public static const POSITION_NODE:String = "position";
		public static const UPDATED_NODE:String = "updated";
		
		public static const ETAG_NODE:String = "etag";
		
		public static const PREFERRED_FORMAT:String = "preferred_format";
		
		private static const TITLE_TYPE_INSTANT:String = "Instant";
		private static const TITLE_TYPE_DVD:String = "DVD";
		
		public static const TITLE_FORMAT_INSTANT:String = "instant";
		public static const TITLE_FORMAT_DVD:String = "DVD";
		public static const TITLE_FORMAT_BLURAY:String = "Blu-ray";
		
		private static const TITLE_STATE_IN_QUEUE:String = "In Queue";
		private static const TITLE_STATE_PLAY:String = "Play";
		private static const TITLE_STATE_ADD:String = "Add";
		private static const TITLE_STATE_AT_HOME:String = "At Home";
		
		public static const BOX_ART_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/box_art";
		
		public static const BOX_ART_TINY_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/box_art/38pix_w";
		public static const BOX_ART_SMALL_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/box_art/64pix_w";
		public static const BOX_ART_LARGE_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/box_art/110pix_w";
		public static const BOX_ART_124_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/box_art/124pix_w";
		public static const BOX_ART_150_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/box_art/150pix_w";
		public static const BOX_ART_88_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/box_art/88pix_w";
		
		public static const TITLE_FORMAT_SCHEMA:String = "http://api.netflix.com/categories/title_formats";
		public static const SCREEN_FORMAT_SCHEMA:String = "http://api.netflix.com/categories/screen_formats";
		public static const TITLE_STATE_SCHEMA:String = "http://api.netflix.com/categories/title_states";
		
		public static const MPAA_RATINGS_SCHEMA:String = "http://api.netflix.com/categories/mpaa_ratings";
		public static const LANGUAGES_AND_AUDIO_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/languages_and_audio";
		public static const SUBTITLE_LANGUAGES_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/subtitle_languages";
		public static const TV_RATING_SCHEMA:String = "http://api.netflix.com/categories/tv_ratings";
		public static const GENRES_SCHEMA:String = "http://api.netflix.com/categories/genres";
		public static const FORMAT_AVAILABILITY_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/format_availability";
		public static const SCREEN_FORMATS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/screen_formats";
		public static const CAST_SCHEMA:String = "http://schemas.netflix.com/catalog/people.cast";
		public static const DIRECTORS_SCHEMA:String = "http://schemas.netflix.com/catalog/people.directors";
		public static const SIMILARS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles.similars";
		public static const SEASONS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles.seasons";
		public static const AWARDS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/awards";
		public static const BONUS_MATERIALS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/bonus_materials";
		public static const EPISODES_SCHEMA:String = "http://schemas.netflix.com/catalog/titles.programs";
		public static const TINY_URL_SCHEMA:String = "http://schemas.netflix.com/catalog/title/ref.tiny";
		public static const NARRATIVE_SCHEMA:String = "http://api.netflix.com/categories/narrative";
		public static const BCP_CODES_SCHEMA:String = "http://api.netflix.com/categories/bcp47_codes";
		public static const QUALITY_SCHEMA:String = "http://api.netflix.com/categories/title_formats/quality";
		public static const DISCS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles.discs";
		public static const LANGUAGES_SCHEMA:String = "http://api.netflix.com/categories/languages";
		
		public static const AVAILABILITY_SCHEMA:String = "http://api.netflix.com/categories/queue_availability";
		public static const TITLE_SCHEMA:String = "http://schemas.netflix.com/catalog/title";
		public static const SERIES_TITLE_SCHEMA:String = "http://schemas.netflix.com/catalog/titles.series";
		public static const AVAILABLE_QUEUE_SCHEMA:String = "http://schemas.netflix.com/queues.available";
		public static const MATURITY_LEVEL_SCHEMA:String = "http://api.netflix.com/categories/maturity_level";
		public static const SYNOPSIS_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/synopsis";
		public static const SYNOPSIS_SHORT_SCHEMA:String = "http://schemas.netflix.com/catalog/titles/synopsis.short";
		public static const QUEUES_SCHEMA:String = "http://schemas.netflix.com/queues";
		public static const RENTAL_HISTORY_SCHEMA:String = "http://schemas.netflix.com/rental_history";
		public static const RECOMMENDATIONS_SCHEMA:String = "http://schemas.netflix.com/recommendations";
		public static const TITLE_STATES_SCHEMA:String = "http://schemas.netflix.com/title_states";
		public static const RATINGS_SCHEMA:String = "http://schemas.netflix.com/ratings";
		public static const REVIEWS_SCHEMA:String = "http://schemas.netflix.com/reviews";
		public static const AT_HOME_SCHEMA:String = "http://schemas.netflix.com/at_home";
		public static const FEEDS_SCHEMA:String = "http://schemas.netflix.com/feeds";
		
		/**
		 * Converts XML to Catalog Model. 
		 * @param xml
		 * @param model
		 * @return CatalogItemModel
		 */		
		public static function handleXMLToCatalogItemModel(xml:XML,item:CatalogItemVO=null):CatalogItemVO
		{
			if(!item)
				item = new CatalogItemVO();
			
			var resultNode:XML;
			var child:XML;
			item.categories = [];
			item.links = [];
			var i:int = -1;
			var n:int = -1;
			var children:XMLList = xml.children();
			
			for each (resultNode in children)
			{
				var nodeType:String = String(resultNode.name());
				switch (nodeType) {
					case ID:
						item.id = handleStringNode(resultNode);
					break;
					case LINK:
						var linkTitle:String = resultNode.@rel;
						switch (linkTitle) {
							case TITLE_SCHEMA:
								var titleChildren:XMLList = resultNode.children();
								if(titleChildren && titleChildren.length()>0)
									handleCatalogTitle(item, titleChildren[0]);
								break;
							/*
							case OFFICIAL_SITE_ATTR:
								item.officialSite = handleLink(resultNode);
							break;
							*/
							default:
								var link:LinkItemVO = handleLink(resultNode);
								item.links.push(link);
								
								if(link.rel == TITLE_SCHEMA)
								{
									item.netflixId = link.url;
									item.titleRegular = link.title;
								} else if(link.rel == SERIES_TITLE_SCHEMA)
								{
									item.groupId = link.url;
								}
							break;
						}
						break;
					case RUNTIME:
						item.runtime = handleNumber(resultNode);
						break;
					case CATEGORY:
						var category:CategoryItemVO = handleCategory(resultNode); 
						item.categories.push(category);
						_handleCategoryNode(item, category);
						break;
					case USER_RATING:
						if(item is RatingsItemVO)
							(item as RatingsItemVO).userRating = handleUserRating(resultNode);
						break;
					case PREDICTED_RATING:
						if(item is RatingsItemVO)
							(item as RatingsItemVO).predictedRating = handleNumber(resultNode);
						break;
					case POSITION_NODE:
						if (item is QueueItemVO)
							(item as QueueItemVO).queuePosition = handleNumber(resultNode);
						break;
					case UPDATED_NODE:
						if (item is QueueItemVO)
							(item as QueueItemVO).lastUpdated = handleDate(resultNode);
						break;
					case SHIPPED_DATE:
						if(item is AtHomeItemVO)
							(item as AtHomeItemVO).shippedDate = handleDate(resultNode);
						break;
					case ESTIMATED_ARRIVAL_DATE:
						if(item is AtHomeItemVO)
							(item as AtHomeItemVO).shippedDate = handleDate(resultNode);
						break;
					case WATCHED_DATE:
						if(item is RentalHistoryItemVO)
							(item as RentalHistoryItemVO).watchedDate = handleDate(resultNode);
						break;
					case RETURNED_DATE:
						if(item is RentalHistoryItemVO)
							(item as RentalHistoryItemVO).returnedDate = handleDate(resultNode);
						break;
					case VIEWED_TIME:
						if(item is RentalHistoryItemVO)
							(item as RentalHistoryItemVO).viewedTime = handleStringNode(resultNode);
						break;
					case AVERAGE_RATING:
						item.averageRating = handleNumber(resultNode);
						break;
				}
			}
			
			if(!item.netflixId)
				item.netflixId = item.id;
			
			if(!item.groupId)
				item.groupId = item.netflixId;

			return item;
			
		}
		
		public static function handleCatalogTitle(item:CatalogItemVO, xml:XML):CatalogItemVO
		{
			var resultNode:XML;
			var children:XMLList = xml.children();
			var child:XML;
			var i:int = -1;
			var n:int = -1;
			for each (resultNode in children)
			{
				var nodeType:String = String(resultNode.name());
				switch (nodeType)
				{
					case ID:
						item.netflixId = handleStringNode(resultNode);
						break;
					case TITLE:
						item.titleShort = resultNode.@short;
						item.titleRegular = resultNode.@regular;
						break;
					case AVERAGE_RATING:
						item.averageRating = handleNumber(resultNode);
						break;
					case RELEASE_YEAR:
						item.releaseYear = handleNumber(resultNode);
						break;
					case SEQUENCE:
						item.sequence = handleInt(resultNode);
						break;
					case SEASON_NUMBER:
						item.seasonNumber = handleInt(resultNode);
						break;
					case CATEGORY:
						var category:CategoryItemVO = handleCategory(resultNode);
						if(!item.categories) item.categories = [];
						item.categories.push(category);
						_handleCategoryNode(item, category);
						break;
					case LINK:
						var linkTitle:String = resultNode.@rel;
						switch (linkTitle) {
							case BOX_ART_SCHEMA:
								if(resultNode.children().length()>0)
									_handleBoxArt(item, resultNode.children()[0]);
								break;
							case SYNOPSIS_SCHEMA:
								item.synopsis = handleLink(resultNode);
								if(resultNode.synopsis)
									item.synopsisString = resultNode.synopsis.toString()
								break;
							case SYNOPSIS_SHORT_SCHEMA:
								item.shortSynopsis = handleLink(resultNode);
								if(resultNode.synopsis)
									item.synopsisShortString = resultNode.short_synopsis.toString()
								break;
							case SCREEN_FORMAT_SCHEMA:
								item.screenFormats = handleLink(resultNode);
								if(resultNode.screen_formats != undefined)
								{
									item.screenFormatsList = [];
									for each(child in resultNode..screen_format)
									item.screenFormatsList.push( handleScreenFormat(child) );
								}
								break;
							case CAST_SCHEMA:
								item.cast = handleLink(resultNode);
								if(resultNode.people != undefined)
								{
									item.castList = [];
									for each(child in resultNode..link)
									item.castList.push(handleLink(child));
								}
								break;
							case DIRECTORS_SCHEMA:
								item.directors = handleLink(resultNode);
								if(resultNode.people != undefined)
								{
									item.directorList = [];
									for each(child in resultNode..link)
									item.directorList.push(handleLink(child));
								}
								break;
							case SIMILARS_SCHEMA:
								item.similars = handleLink(resultNode);
								if(resultNode.catalog_titles != undefined)
								{
									item.similarsList = [];
									for each(child in resultNode..link)
									item.similarsList.push(handleLink(child));
								}
								break;
							case DISCS_SCHEMA:
								item.discs = handleLink(resultNode);
								if(resultNode.catalog_titles != undefined)
								{
									item.discsList = [];
									for each(child in resultNode..link)
										item.discsList.push(handleLink(child));
								}
								break;
							case FORMAT_AVAILABILITY_SCHEMA:
								item.formats = handleLink(resultNode);
								if(resultNode.delivery_formats != undefined)
								{
									item.formatsList = [];
									for each(child in resultNode..availability)
										item.formatsList.push(handleFormatAvailability(child));
									
									i = -1;
									n = item.formatsList.length;
									var format:FormatAvailabilityVO;
									while(++i<n)
									{
										format = item.formatsList[i] as FormatAvailabilityVO;
										if(format.label == TITLE_FORMAT_INSTANT)
											item.isInstant = true;
										else if(format.label == TITLE_FORMAT_DVD)
											item.isDvd = true;
										else if(format.label == TITLE_FORMAT_BLURAY)
											item.isBluray = true;
									}
								}
								break;
							case SEASONS_SCHEMA:
								item.seasons = handleLink(resultNode);
								if(resultNode.catalog_titles != undefined)
								{
									item.seasonsList = [];
									for each(child in resultNode..link)
									item.seasonsList.push( handleLink(child) );
								}
								break;
							case AWARDS_SCHEMA:
								item.awards = handleLink(resultNode);
								if(resultNode.awards != undefined)
								{
									item.awardsList = [];
									for each(child in resultNode..award_winner)
									{
										if(!item.awardsWinnerList)
											item.awardsWinnerList = [];
										var awardWinner:AwardWinnerVO = handleAwardsWinners(child);
										item.awardsWinnerList.push( awardWinner );
										item.awardsList.push( awardWinner );
									}
									for each(child in resultNode..award_nominee)
									{
										if(!item.awardsNomineeList)
											item.awardsNomineeList = [];
										var awardNominee:AwardNomineeVO = handleAwardNominees(child);
										item.awardsNomineeList.push( awardNominee );
										item.awardsList.push( awardNominee );
									}
								}
								break;
							case EPISODES_SCHEMA:
								item.episodes = handleLink(resultNode);
								if(resultNode.catalog_titles != undefined)
								{
									item.episodesList = [];
									for each(child in resultNode..link)
									item.episodesList.push( handleLink(child) );
								}
								break;
							case NETFLIX_PAGE_ATTR:
								item.webPage = handleLink(resultNode);
								break;
							case TINY_URL_SCHEMA:
								item.tinyUrl = handleLink(resultNode);
								break;
						}
						break;
				}
			}
			return item;
		}
		
		private static function _handleCategoryNode(item:CatalogItemVO, category:CategoryItemVO):CatalogItemVO
		{
			if(category.scheme.indexOf(GENRES_SCHEMA)>-1)
				item.genres.push(category.label);
			else if(category.scheme == MPAA_RATINGS_SCHEMA && category.label!="null")
				item.rating = category.label;
			else if(category.scheme == TV_RATING_SCHEMA && category.label!="null")
				item.rating = category.label;
			else if(item is QueueItemVO && category.scheme == AVAILABILITY_SCHEMA)
				(item as QueueItemVO).availabilityLabel = category.label;
			else if(item is QueueItemVO && category.scheme == TITLE_FORMAT_SCHEMA)
				(item as QueueItemVO).format = category.label;
			else if(category.scheme == MATURITY_LEVEL_SCHEMA)
				item.maturityLevel = category.label;
			
			return item;
		}
		
		private static function _handleBoxArt(item:CatalogItemVO, xml:XML):CatalogItemVO
		{
			var resultNode:XML;
			var children:XMLList = xml.children();
			var i:int = -1;
			var n:int = children.length();
			while(++i<n)
			{
				var link:LinkItemVO = handleLink(children[i] as XML);
				switch(link.rel)
				{
					case BOX_ART_TINY_SCHEMA:
						item.boxArtTiny = link.url;
						break;
					case BOX_ART_SMALL_SCHEMA:
						item.boxArtSmall = link.url;
						break;
					case BOX_ART_LARGE_SCHEMA:
						item.boxArtLarge = link.url;
						break;
					case BOX_ART_88_SCHEMA:
						item.boxArt88 = link.url;
						break;
					case BOX_ART_124_SCHEMA:
						item.boxArt124 = link.url;
						break;
					case BOX_ART_150_SCHEMA:
						item.boxArt150 = link.url;
						break;
				}
			}
			return item;
		}
		
		/**
		 * Handles the parsing of a <code>person</code> node. 
		 * @param xml <code>person</code> node
		 * @return PersonVO
		 * 
		 */		
		public static function handlePerson(xml:XML):PersonVO {
			var resultNode:XML;
			var personVO:PersonVO = new PersonVO;
			personVO.links = [];
			var children:XMLList = xml.children();
			
			for each (resultNode in children)
			{
				var nodeType:String = String(resultNode.name());
				switch (nodeType) {
					case LINK:
						var linkType:String = resultNode.@title;
						switch (linkType) {
							case FILMOGRAPHY_ATTR:
								personVO.filmography = handleLink(resultNode);
							break;
							case NETFLIX_PAGE_ATTR:
								personVO.webPage = handleLink(resultNode);
							break;
							default:
								personVO.links.push(handleLink(resultNode));
							break;
						}
					break;
					case BIO:
						personVO.bio = handleStringNode(resultNode);
					break;
					case NAME:
						personVO.name = handleStringNode(resultNode);
					break;
					case ID:
						personVO.id = handleStringNode(resultNode);
					break;
				}
			}
			return personVO
		}
		
		/**
		 * Handles the ID node parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleStringNode(xml:XML):String
		{
			return String(xml.valueOf());
		}
		
		/**
		 * Handles the Release Year node parsing.
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleNumber(xml:XML):Number {
			return Number(xml.valueOf());
		}
		
		public static function handleInt(xml:XML):int {
			return int(xml.valueOf());
		}
		
		public static function handleUserRating(xml:XML):int
		{
			if(xml.@value && xml.@value=="not_interested")
				return -1;
			return handleInt(xml);
		}
		
		public static function handleBoolean(xml:XML):Boolean
		{
			return (xml.valueOf() == "true")?true:false;
		}
		
		/**
		 * Handles the Link node parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleLink(xml:XML):LinkItemVO {
			var linkVO:LinkItemVO = new LinkItemVO();
			linkVO.url = xml.@href;
			linkVO.rel = xml.@rel;
			linkVO.title = xml.@title;
			var children:XMLList = xml.children();
			var n:int = children.length();
			if(n > 0)
			{
				linkVO.expansion = [];
				var childXML:XML = xml.children()[0] as XML;
				linkVO.expansionTitle = String(childXML.name());
				var subchildren:XMLList = childXML.children();
				for each( var linkXML:XML in subchildren)
				{
					if (linkXML.name() == LINK)
						linkVO.expansion.push(handleLink(linkXML));
				}
			}
			return linkVO;
		}
		
		/**
		 * Handles the Category node parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleCategory(xml:XML):CategoryItemVO{
			var category:CategoryItemVO = new CategoryItemVO();
			category.scheme = xml.@scheme;
			category.label = xml.@label;
			category.term = xml.@term;
			return category;
		}
		
		/**
		 * Handle Updated Date parsing. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleDate(xml:XML):Date
		{
			return handleDateValue(String(xml.valueOf()));
		}
		
		public static function handleDateValue(value:String):Date
		{
			return new Date(Number(value)*1000);
		}
		
		/**
		 * Handles the parsing of Format Availability Results. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleFormatAvailability(xml:XML):FormatAvailabilityVO
		{
			var availability:FormatAvailabilityVO = new FormatAvailabilityVO();
			availability.label = xml.category.@label;
			availability.term = xml.category.@term;
			availability.scheme = xml.category.@scheme;
			availability.availableUntil = (xml.@available_until!=undefined)?handleDateValue(xml.@available_until):null;
			availability.availableFrom = (xml.@available_from!=undefined)?handleDateValue(xml.@available_from):null;
			//
			var resultNode:XML;
			var children:XMLList = xml.children();
			var child:XML;
			
			for each (resultNode in children)
			{
				var nodeType:String = String(resultNode.name());
				switch (nodeType) {
					case CATEGORY:
						var i:int = -1;
						var subchildren:XMLList = resultNode.children();
						var n:int = subchildren.length();
						while(++i<n)
						{
							var subChild:XML = subchildren[i] as XML;
							var subChildType:String = String(subChild.name());
							switch(subChildType)
							{
								case CATEGORY:
									var category:CategoryItemVO = handleCategory(subChild);
									switch(category.scheme)
									{
										case MPAA_RATINGS_SCHEMA:
											availability.rating = category.label;
											break;
										case TV_RATING_SCHEMA:
											availability.rating = category.label;
											break;
										case QUALITY_SCHEMA:
											availability.quality = category.label;
											break;
									}
									break;
								case LINK:
									var linkTitle:String = subChild.@rel;
									var j:int;
									var m:int;
									var xmlList:XMLList;
									switch(linkTitle)
									{
										case LANGUAGES_AND_AUDIO_SCHEMA:
											availability.languagesAndAudio = handleLink(subChild);
											if(subChild.language_audio_format != undefined)
											{
												availability.languagesAndAudioList = [];
												xmlList = subChild.language_audio_format.children();
												j = -1;
												m = xmlList.length();
												while(++j<m)
													availability.languagesAndAudioList.push( handleLanguageAudioFormat(xmlList[j] as XML) );
											}
											break;
										case SUBTITLE_LANGUAGES_SCHEMA:
											availability.subtitlesAndLanguages = handleLink(subChild);
											if(subChild.subtitle_languages != undefined)
											{
												availability.subtitlesAndLanguagesList = [];
												xmlList = subChild.subtitle_languages.children();
												j = -1;
												m = xmlList.length();
												while(++j<m)
													availability.subtitlesAndLanguagesList.push( handleSubtitle(xmlList[j] as XML) );
											}
											break;
									}
									break;
							}
						}
						break;
					case RUNTIME:
						availability.runtime = handleNumber(resultNode);
						break;
				}
			}
			//
			return availability;
		}
		/**
		 * Handles the parsing of Awards Nominee Results. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleAwardsWinners(xml:XML):AwardWinnerVO
		{
			var award:AwardWinnerVO = new AwardWinnerVO();
			award.year = xml.@year;
			award.category = handleCategory(award.category as XML);
			award.link = new LinkItemVO();
			award.link.url = xml.link.@href;
			award.link.rel = xml.link.@rel;
			award.link.title = xml.link.@title;
			return award;
		}
		/**
		 * Handles the parsing of Awards Nominee Results. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleAwardNominees(xml:XML):AwardNomineeVO
		{
			var award:AwardNomineeVO = new AwardNomineeVO();
			award.year = xml.@year;
			award.category = handleCategory(award.category as XML);
			award.link = new LinkItemVO();
			award.link.url = xml.link.@href;
			award.link.rel = xml.link.@rel;
			award.link.title = xml.link.@title;
			return award;
		}
		/**
		 * Handles the parsing of Screen Formats Results.  
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleScreenFormat(xml:XML):ScreenFormatVO
		{
			var screenFormat:ScreenFormatVO = new ScreenFormatVO();
			screenFormat.categories = [];
			for each(var x:XML in xml..category)
			{
				var category:CategoryItemVO = handleCategory(x);
				if(category.scheme == TITLE_FORMAT_SCHEMA)
					screenFormat.titleFormat = category.label;
				else if(category.scheme == SCREEN_FORMAT_SCHEMA)
					screenFormat.screenFormat = category.label;
				screenFormat.categories.push(category);
			}
			return screenFormat;
		}
		
		public static function handleSubtitle(xml:XML):SubtitleVO
		{
			var subtitle:SubtitleVO = new SubtitleVO();
			subtitle.label = xml.@label;
			subtitle.scheme = xml.@scheme;
			subtitle.term = xml.@term;
			for each(var x:XML in xml..category)
			{
				var category:CategoryItemVO = handleCategory(x);
				switch(category.scheme)
				{
					case NARRATIVE_SCHEMA:
						subtitle.primary = true;
						break;
					case BCP_CODES_SCHEMA:
						subtitle.code = category.label;
						break;
				}
			}
			return subtitle;
		}
		
		/**
		 * Handles the parsing of Language and Audio Formats. 
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleLanguageAudioFormat(xml:XML):LangaugeFormatVO
		{
			var language:LangaugeFormatVO = new LangaugeFormatVO();
			language.language = handleCategory(xml).label;
			language.audioFormats = [];
			
			var children:XMLList = xml.children();
			for each(var x:XML in children)
				language.audioFormats.push( handleCategory(x).label );
			
			return language;
		}
		
		/**
		 * Handles the parsing of Filmography Results.
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleFilmography(xml:XML):FilmographyItemVO
		{
			return NetflixXMLUtil.handleXMLToCatalogItemModel(xml) as FilmographyItemVO;
		}
		
		/**
		 * Handles the parsing of Title States.
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleTitleState(xml:XML):TitleStateVO
		{
			var titleState:TitleStateVO = new TitleStateVO();
			titleState.url = xml.link.@href;
			titleState.rel = xml.link.@rel;
			titleState.title = xml.link.@title;
			//formats
			var titleStates:XMLList = xml..title_state_item;
			if(titleStates.length() > 0)
			{
				titleState.titleStates = [];
				for each(var titleStateXML:XML in titleStates)
				{
					var titleStateItem:TitleStateItemVO = new TitleStateItemVO();
					var titleStateChildren:XMLList = titleStateXML.children();
					for each (var titleStateNode:XML in titleStateChildren)
					{
						var titleStateNodeType:String = String(titleStateNode.name());
						switch(titleStateNodeType)
						{
							case LINK:
								if(String(titleStateNode.@rel).indexOf("item")>-1)
								{
									titleStateItem.queueId = titleStateItem.url = titleStateNode.@href;
									titleStateItem.rel = titleStateNode.@rel;
									titleStateItem.title = titleStateNode.@title;
								}
								break;
							case FORMAT:
								titleStateItem.formats = [];
								var categoryItem:CategoryItemVO;
								var formatChildren:XMLList = titleStateXML.format.children();
								for each(var resultNode:XML in formatChildren)
								{
									var nodeType:String = String(resultNode.name());
									switch(nodeType)
									{
										case CATEGORY:
											categoryItem = handleCategory(resultNode);
											titleStateItem.formats.push( categoryItem );
											if(categoryItem.scheme==TITLE_FORMAT_SCHEMA)
											{
												if(categoryItem.term==TITLE_TYPE_DVD)
													titleState.isDisc = titleStateItem.isDisc = true;
												else if(categoryItem.term==TITLE_TYPE_INSTANT)
													titleState.isInstant = titleStateItem.isInstant = true;
												else if(categoryItem.term=="Play")
													titleState.isInstantPlay = true;
												else if(categoryItem.term=="Add")
													titleStateItem.isInQueue = false;
												else if(categoryItem.term=="In Queue")
													titleStateItem.isInQueue = true;
											}
										break;
										case WATCHED_DATE:
											titleStateItem.watchedDate = handleDate(resultNode);
											break;
										case PREFERRED_FORMAT:
											titleStateItem.preferredFormat = handleBoolean(resultNode);
										break;
									}
								}
								titleState.titleStates.push(titleStateItem);
								break;
						}
					}
					//title state item transform
					var i:int = -1;
					var n:int = titleStateItem.formats.length;
					while(++i<n)
					{
						categoryItem = titleStateItem.formats[i] as CategoryItemVO;
						if(titleStateItem.isDisc)
						{
							if(categoryItem.term==TITLE_STATE_ADD)
								titleState.addToDisc = true;
							else if(categoryItem.term==TITLE_STATE_AT_HOME)
								titleState.isAtHome = true;
							else if(categoryItem.term==TITLE_STATE_IN_QUEUE)
								titleState.isInDiscQueue = true;
						} else if(titleStateItem.isInstant)
						{
							if(categoryItem.term==TITLE_STATE_ADD)
								titleState.addToInstant = true;
							else if(categoryItem.term==TITLE_STATE_PLAY)
								titleState.isInstantPlay = true;
							else if(categoryItem.term==TITLE_STATE_IN_QUEUE)
								titleState.isInInstantQueue = true;
						}
					}
				}
			}
			
			return titleState;
		}
		
		public static function handleRssResult(xml:XML):Array
		{
			var items:Array = [];
			var itemNode:XML;
			for each(itemNode in xml..item){
				items.push( String(itemNode.link) );
			}
			return items;
		}
		
		//-----------------------------
		//  handle generic xml result
		//-----------------------------
		/**
		 * Handles an unknown result and based on template returns correct result.
		 * 
		 * Incomplete.
		 *  
		 * @param xml
		 * @return 
		 * 
		 */		
		public static function handleXMLResult(xml:XML):Array
		{
			// get template for evaluation
			var urlTemplate:String = (xml.url_template)?xml.url_template:null;
			// if no template, die
			if(!urlTemplate)
				return [];
			
			// temp
			var ratingsTitleUrlTemplate:String = "http://api.netflix.com/users/"+ServiceStorage.getInstance().user.userId+"/ratings/title?{-join|&amp;|title_refs}";
			
			return [];
		}
		
	}
}
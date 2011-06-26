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
package com.netflix.webapis.vo
{
	
	[RemoteClass(alias="com.netflix.webapis.vo.CatalogItemVO")]
	/**
	 * Base Model Class for all Catalog Items. 
	 * @author jonbcampos
	 * 
	 */	
	public class CatalogItemVO
	{
		public function CatalogItemVO()
		{
			super();
		}
		
		//static properties
		public static const EXPAND_QUEUE_ITEM:String = "@queue_item";
		public static const EXPAND_AT_HOME_ITEM:String = "@at_home_item";
		public static const EXPAND_RENTAL_HISTORY_ITEM:String = "@rental_history_item";
		public static const EXPAND_RECOMMENDATION_ITEM:String = "@recommendation";
		public static const EXPAND_FILMOGRAPHY_ITEM:String = "@filmography_item";
		public static const EXPAND_RATINGS_ITEM:String = "@ratings_item";
		
		public static const EXPAND_TITLE:String = "@title";
		
		public static const EXPAND_BOX_ART:String = "@box_art";
		public static const EXPAND_SYNOPSIS:String = "@synopsis";
		public static const EXPAND_SHORT_SYNOPSIS:String = "@short_synopsis";
		public static const EXPAND_FORMATS:String = "@formats";
		public static const EXPAND_SCREEN_FORMATS:String = "@screen_formats";
		public static const EXPAND_CAST:String = "@cast";
		public static const EXPAND_DIRECTORS:String = "@directors";
		public static const EXPAND_LANGUAGES_AND_AUDIO:String = "@languages_and_audio";
		public static const EXPAND_SUBTITLE_LANGUAGES:String = "@subtitle_languages";
		public static const EXPAND_SEASONS:String = "@seasons";
		public static const EXPAND_EPISODES:String = "@episodes";
		public static const EXPAND_DISCS:String = "@discs";
		public static const EXPAND_SIMILARS:String = "@similars";
		public static const EXPAND_FILMOGRAPHY:String = "@filmography";
		public static const EXPAND_BONUS_MATERIALS:String = "@bonus_materials";
		public static const EXPAND_AWARDS:String = "@awards";
		
		//properties
		/**
		 * Netflix URL Id. Not a specific unique id number. 
		 */		
		public var id:String;
		/**
		 * Unique title id. 
		 */		
		public var netflixId:String;
		public var groupId:String;
		/**
		 * Short Verison of Catalog Title. 
		 */		
		public var titleShort:String;
		/**
		 * Complete Catalog Item Title. 
		 */		
		public var titleRegular:String;
		/**
		 * Box Art: 38x53. 
		 */		
		public var boxArtTiny:String;
		/**
		 * Box Art: 64x90. 
		 */		
		public var boxArtSmall:String;
		/**
		 * Box Art: 110x150. 
		 */		
		public var boxArtLarge:String;
		/**
		 * Box Art: 124x172. 
		 */		
		public var boxArt124:String;
		/**
		 * Box Art: 150x214. 
		 */		
		public var boxArt150:String;
		/**
		 * Box Art: 88x120. 
		 */		
		public var boxArt88:String;
		
		public var maturityLevel:String;
		
		/**
		 * Title rating. 
		 */		
		public var rating:String = "NR";
		/**
		 * Year of release. 
		 */		
		public var releaseYear:Number;
		/**
		 * Runtime in seconds. 
		 */		
		public var runtime:Number;
		/**
		 * Average Popular Rating. 
		 */		
		public var averageRating:Number;
		/**
		 * Date of last update.
		 */		
		public var lastUpdated:Date;
		
		public var seasonNumber:int;
		public var sequence:int;

		[ArrayElementType("com.netflix.webapis.vo.CategoryItemVO")]
		/**
		 * Title Genres. 
		 */		
		public var genres:Array = [];
		
		//additional categories
		[ArrayElementType("com.netflix.webapis.vo.CategoryItemVO")]
		/**
		 * Array of Catalogy Items. Can be matched with items from the Categoies Service.
		 * 
		 * @see com.netflix.webapis.services.CategoriesService 
		 * @see com.netflix.webapis.vo.CategoryItem
		 */		
		public var categories:Array;
		//additional links
		[ArrayElementType("com.netflix.webapis.vo.LinkItemVO")]
		/**
		 * Array of Link Items.
		 * 
		 * @see com.netflix.webapis.vo.LinkItem
		 */		
		public var links:Array;
		
		/**
		 * Title State.
		 * 
		 * <p>
		 * <code>null</code> by default. You can call
		 * for multiple title states using the
		 * <code>UserService.TITLES_STATES_SERVICE</code>
		 * or by calling the <code>getTitleState()</code>.
		 * </p>
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel#getTitleState()
		 * @see com.netflix.webapis.services.UserService#TITLES_STATES_SERVICE
		 * @see com.netflix.webapis.services.UserService#getTitlesStates()
		 */		
		public var titleState:TitleStateVO;
		
		//links
		/**
		 * Catalog Item's Synopsis Link Item. 
		 */		
		public var synopsis:LinkItemVO;
		/**
		 * Catalog Item's Short Synopsis Link Item. 
		 */		
		public var shortSynopsis:LinkItemVO;
		/**
		 * Catalog Item's Cast Link Item. 
		 */		
		public var cast:LinkItemVO;
		/**
		 * Catalog Item's Directors Link Item. 
		 */		
		public var directors:LinkItemVO;
		/**
		 * Catalog Item's Awards Link Item. 
		 */		
		public var awards:LinkItemVO;
		/**
		 * Catalog Item's Screen Formats Link Item. 
		 */		
		public var screenFormats:LinkItemVO;
		/**
		 * Catalog Item's Seasons Link Item. 
		 */		
		public var seasons:LinkItemVO;
		/**
		 * Catalog Item's Episodes Link Item.
		 */		
		public var episodes:LinkItemVO;
		/**
		 * Catalog Item's Similars Link Item.
		 */		
		public var similars:LinkItemVO;
		/**
		 * Catalog Item's Official Site Link Item.
		 */		
		public var officialSite:LinkItemVO;
		/**
		 * Catalog Item's Web Page Link Item.
		 */		
		public var webPage:LinkItemVO;
		
		public var tinyUrl:LinkItemVO;
		/**
		 * Catalog Item's Formats Link Item.
		 */		
		public var formats:LinkItemVO;
		/**
		 * Catalog Item's Discs Link Item.
		 */		
		public var discs:LinkItemVO;
		
		/**
		 * Flag to signify if the title is an instant view title. 
		 */		
		public var isInstant:Boolean;
		
		/**
		 * Flag to signify if the title is a disc title. 
		 */		
		public var isDvd:Boolean;
		
		/**
		 * Flag to signify if the title is a bluray title. 
		 */		
		public var isBluray:Boolean;
		
		

		//-----------------------------
		//  expand items
		//-----------------------------
		[ArrayElementType("com.netflix.webapis.vo.PersonVO")]
		/**
		 * Catalog Item's Cast List Expansion. Array of Person.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.PersonVO
		 */
		public var castList:Array;

		[ArrayElementType("com.netflix.webapis.vo.TitleFormatVO")]
		/**
		 * Catalog Item's Formats List Expansion. Array of TitleFormat.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.TitleFormatVO
		 */
		public var formatsList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.ScreenFormatVO")]
		/**
		 * Catalog Item's Screen Formats List Expansion. Array of ScreenFormat.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.ScreenFormat
		 */
		public var screenFormatsList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.CatalogItemVO")]
		/**
		 * Catalog Item's Similars List Expansion. Array of CatalogItemModelBases.
		 * 
		 * @return 
		 */
		public var similarsList:Array;
		
		/**
		 * Catalog Item's Synopsis Expansion.
		 * 
		 * @return 
		 */
		public var synopsisString:String;
		/**
		 * Catalog Item's Short Synopsis Expansion.
		 * 
		 * @return 
		 */
		public var synopsisShortString:String;
		
		[ArrayElementType("com.netflix.webapis.vo.PersonVO")]
		/**
		 * Catalog Item's Director List Expansion. Array of Person.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.Person
		 */
		public var directorList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.AwardWinnerVO")]
		/**
		 * Catalog Item's Award List Expansion. Array of AwardWinner.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.AwardWinner
		 */
		public var awardsWinnerList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.AwardNomineeVO")]
		/**
		 * Catalog Item's Award List Expansion. Array of AwardNominee.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.AwardNominee
		 */
		public var awardsNomineeList:Array;
		
		/**
		 * Catalog Item's Award List Expansion. Array of AwardNominee && AwardWinner.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.AwardNominee
		 * @see com.netflix.webapis.vo.AwardWinner
		 */
		public var awardsList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.CatalogItemVO")]
		/**
		 * Catalog Item's Disc List Expansion. Array of CatalogItemModel.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public var discsList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.CatalogItemVO")]
		/**
		 * Catalog Item's Episodes List Expansion. Array of CatalogTitleVO.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public var episodesList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.CatalogItemVO")]
		/**
		 * Catalog Item's Seasons List Expansion. Array of CatalogTitleVO.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.CatalogItemModel
		 */
		public var seasonsList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.FilmographyItemVO")]
		/**
		 * Catalog Item's Filmography List Expansion. Array of FilmographyItemModels.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.models.FilmographyItemModel
		 */
		public var filmographyList:Array;
		
		[ArrayElementType("com.netflix.webapis.vo.LinkItemVO")]
		/**
		 * Catalog Item's Bonus Materials List Expansion. Array of LinkItem.
		 * 
		 * @return 
		 * 
		 * @see com.netflix.webapis.vo.LinkItem
		 */
		public var bonusMaterialsList:Array;
		
	}
}
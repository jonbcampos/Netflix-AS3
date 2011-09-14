package com.netflix.webapis.services
{
	import com.netflix.webapis.ServiceFault;
	import com.netflix.webapis.events.NetflixFaultEvent;
	import com.netflix.webapis.events.NetflixResultEvent;
	import com.netflix.webapis.params.ParamsBase;
	import com.netflix.webapis.xml.NetflixXMLUtilV2;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	[Event(name="top100Result",type="com.netflix.webapis.events.NetflixResultEvent")]
	[Event(name="newReleasesResult",type="com.netflix.webapis.events.NetflixResultEvent")]
	[Event(name="newInstantResult",type="com.netflix.webapis.events.NetflixResultEvent")]
	[Event(name="feedResult",type="com.netflix.webapis.events.NetflixResultEvent")]
	
	public class RssService extends ServiceBase
	{
		public function RssService()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		// Public Static Consts
		//
		//---------------------------------------------------------------------
		public static const TOP_100_SERVICE:String = "top100";
		public static const NEW_RELEASES_SERVICE:String = "newReleases";
		public static const NEW_INSTANT_SERVICE:String = "newInstant";
		public static const FEED_SERVICE:String = "feed";
		
		public static const TOP_25_IN_ACTION_AND_ADVENTURE:String = "http://rss.netflix.com/Top25RSS?gid=296";
		public static const TOP_25_IN_BIOGRAPHICAL_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=300";
		public static const TOP_25_IN_CHILDREN_AND_FAMILY:String = "http://rss.netflix.com/Top25RSS?gid=302";
		public static const TOP_25_IN_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=306";
		public static const TOP_25_IN_COMEDY:String = "http://rss.netflix.com/Top25RSS?gid=307";
		public static const TOP_25_IN_COURTROOM_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=311";
		public static const TOP_25_IN_CRIME_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=312";
		public static const TOP_25_IN_BIOGRAPHIES:String = "http://rss.netflix.com/Top25RSS?gid=314";
		public static const TOP_25_IN_DRAMA:String = "http://rss.netflix.com/Top25RSS?gid=315";
		public static const TOP_25_IN_EDUCATION_AND_GUIDANCE:String = "http://rss.netflix.com/Top25RSS?gid=318";
		public static const TOP_25_IN_EROTIC_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=320";
		public static const TOP_25_IN_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=323";
		public static const TOP_25_IN_FILM_NOIR:String = "http://rss.netflix.com/Top25RSS?gid=324";
		public static const TOP_25_IN_GAY_AND_LESBIAN:String = "http://rss.netflix.com/Top25RSS?gid=330";
		public static const TOP_25_IN_EPICS:String = "http://rss.netflix.com/Top25RSS?gid=333";
		public static const TOP_25_IN_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=338";
		public static const TOP_25_IN_IMAX:String = "http://rss.netflix.com/Top25RSS?gid=340";
		public static const TOP_25_IN_INDEPENDENT:String = "http://rss.netflix.com/Top25RSS?gid=343";
		public static const TOP_25_IN_MYSTERY:String = "http://rss.netflix.com/Top25RSS?gid=357";
		public static const TOP_25_IN_SUSPENSE:String = "http://rss.netflix.com/Top25RSS?gid=358";
		public static const TOP_25_IN_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=371";
		public static const TOP_25_IN_SCI_FI_AND_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=373";
		public static const TOP_25_IN_STAND_UP:String = "http://rss.netflix.com/Top25RSS?gid=381";
		public static const TOP_25_IN_TEEN_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=385";
		public static const TOP_25_IN_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=387";
		public static const TOP_25_IN_WESTERNS:String = "http://rss.netflix.com/Top25RSS?gid=390";
		public static const TOP_25_IN_ACTION_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=615";
		public static const TOP_25_IN_ACTION_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=616";
		public static const TOP_25_IN_ACTION_SCI_FI_AND_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=617";
		public static const TOP_25_IN_ACTION_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=618";
		public static const TOP_25_IN_ANIMAL_TALES:String = "http://rss.netflix.com/Top25RSS?gid=619";
		public static const TOP_25_IN_CARTOONS:String = "http://rss.netflix.com/Top25RSS?gid=620";
		public static const TOP_25_IN_CLASSIC_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=621";
		public static const TOP_25_IN_ALIEN_SCI_FI:String = "http://rss.netflix.com/Top25RSS?gid=622";
		public static const TOP_25_IN_ANIME_AND_ANIMATION:String = "http://rss.netflix.com/Top25RSS?gid=623";
		public static const TOP_25_IN_DARK_HUMOR_AND_BLACK_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=626";
		public static const TOP_25_IN_BLOCKBUSTERS:String = "http://rss.netflix.com/Top25RSS?gid=627";
		public static const TOP_25_IN_BOOK_CHARACTERS:String = "http://rss.netflix.com/Top25RSS?gid=634";
		public static const TOP_25_IN_BEST_OF_BRITISH_HUMOR:String = "http://rss.netflix.com/Top25RSS?gid=635";
		public static const TOP_25_IN_CLASSIC_SCI_FI_AND_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=637";
		public static const TOP_25_IN_CLASSIC_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=638";
		public static const TOP_25_IN_CLASSIC_WAR_STORIES:String = "http://rss.netflix.com/Top25RSS?gid=639";
		public static const TOP_25_IN_CLASSIC_WESTERNS:String = "http://rss.netflix.com/Top25RSS?gid=640";
		public static const TOP_25_IN_COMIC_BOOKS_AND_SUPERHEROES:String = "http://rss.netflix.com/Top25RSS?gid=642";
		public static const TOP_25_IN_CRIME_ACTION:String = "http://rss.netflix.com/Top25RSS?gid=643";
		public static const TOP_25_IN_CREATURE_FEATURES:String = "http://rss.netflix.com/Top25RSS?gid=644";
		public static const TOP_25_IN_CRIME_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=646";
		public static const TOP_25_IN_EXPERIMENTAL:String = "http://rss.netflix.com/Top25RSS?gid=648";
		public static const TOP_25_IN_DEADLY_DISASTERS:String = "http://rss.netflix.com/Top25RSS?gid=650";
		public static const TOP_25_IN_DISNEY:String = "http://rss.netflix.com/Top25RSS?gid=651";
		public static const TOP_25_IN_CRIME_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=652";
		public static const TOP_25_IN_HISTORICAL_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=653";
		public static const TOP_25_IN_MISCELLANEOUS_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=654";
		public static const TOP_25_IN_FAMILY_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=656";
		public static const TOP_25_IN_FAMILY_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=657";
		public static const TOP_25_IN_FRANKENSTEIN:String = "http://rss.netflix.com/Top25RSS?gid=665";
		public static const TOP_25_IN_GAY_AND_LESBIAN_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=666";
		public static const TOP_25_IN_GAY_AND_LESBIAN_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=667";
		public static const TOP_25_IN_GAY_AND_LESBIAN_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=668";
		public static const TOP_25_IN_CHRISTMAS:String = "http://rss.netflix.com/Top25RSS?gid=671";
		public static const TOP_25_IN_MARTIAL_ARTS:String = "http://rss.netflix.com/Top25RSS?gid=672";
		public static const TOP_25_IN_HORROR_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=673";
		public static const TOP_25_IN_INDIE_ACTION:String = "http://rss.netflix.com/Top25RSS?gid=674";
		public static const TOP_25_IN_INDIE_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=675";
		public static const TOP_25_IN_INDIE_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=676";
		public static const TOP_25_IN_INDIE_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=677";
		public static const TOP_25_IN_MILITARY_AND_WAR_ACTION:String = "http://rss.netflix.com/Top25RSS?gid=679";
		public static const TOP_25_IN_MILITARY_AND_WAR_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=680";
		public static const TOP_25_IN_MOBSTER:String = "http://rss.netflix.com/Top25RSS?gid=681";
		public static const TOP_25_IN_POLITICAL_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=684";
		public static const TOP_25_IN_PSYCHOLOGICAL_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=685";
		public static const TOP_25_IN_ROMANCE_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=691";
		public static const TOP_25_IN_ROMANTIC_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=692";
		public static const TOP_25_IN_ROMANTIC_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=693";
		public static const TOP_25_IN_SATANIC_STORIES:String = "http://rss.netflix.com/Top25RSS?gid=695";
		public static const TOP_25_IN_SATURDAY_NIGHT_LIVE:String = "http://rss.netflix.com/Top25RSS?gid=696";
		public static const TOP_25_IN_SCREWBALL:String = "http://rss.netflix.com/Top25RSS?gid=699";
		public static const TOP_25_IN_SHOWBIZ_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=701";
		public static const TOP_25_IN_SILENT_FILMS:String = "http://rss.netflix.com/Top25RSS?gid=702";
		public static const TOP_25_IN_SLASHERS_AND_SERIAL_KILLERS:String = "http://rss.netflix.com/Top25RSS?gid=703";
		public static const TOP_25_IN_ESPIONAGE_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=705";
		public static const TOP_25_IN_SPOOFS_AND_SATIRE:String = "http://rss.netflix.com/Top25RSS?gid=706";
		public static const TOP_25_IN_STEAMY_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=709";
		public static const TOP_25_IN_SUPERNATURAL_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=710";
		public static const TOP_25_IN_TEARJERKERS:String = "http://rss.netflix.com/Top25RSS?gid=711";
		public static const TOP_25_IN_TEEN_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=712";
		public static const TOP_25_IN_TEEN_SCREAMS:String = "http://rss.netflix.com/Top25RSS?gid=713";
		public static const TOP_25_IN_VAMPIRES:String = "http://rss.netflix.com/Top25RSS?gid=717";
		public static const TOP_25_IN_WEREWOLVES:String = "http://rss.netflix.com/Top25RSS?gid=718";
		public static const TOP_25_IN_ZOMBIES:String = "http://rss.netflix.com/Top25RSS?gid=719";
		public static const TOP_25_IN_SUPERNATURAL_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=730";
		public static const TOP_25_IN_B_MOVIE_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=745";
		public static const TOP_25_IN_POLITICAL_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=747";
		public static const TOP_25_IN_CULT_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=748";
		public static const TOP_25_IN_SCI_FI_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=757";
		public static const TOP_25_IN_CLASSIC_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=758";
		public static const TOP_25_IN_PERIOD_PIECES:String = "http://rss.netflix.com/Top25RSS?gid=796";
		public static const TOP_25_IN_PUNK_ROCK:String = "http://rss.netflix.com/Top25RSS?gid=797";
		public static const TOP_25_IN_MONSTERS:String = "http://rss.netflix.com/Top25RSS?gid=834";
		public static const TOP_25_IN_FAMILY_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=841";
		public static const TOP_25_IN_LATE_NIGHT_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=847";
		public static const TOP_25_IN_MILITARY_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=856";
		public static const TOP_25_IN_FAITH_AND_SPIRITUALITY_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=857";
		public static const TOP_25_IN_SCIENCE_AND_NATURE_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=858";
		public static const TOP_25_IN_DOCUMENTARY:String = "http://rss.netflix.com/Top25RSS?gid=864";
		public static const TOP_25_IN_BIG3:String = "http://rss.netflix.com/Top25RSS?gid=900";
		public static const TOP_25_IN_SHOWBIZ_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=1016";
		public static const TOP_25_IN_KIDS_TV:String = "http://rss.netflix.com/Top25RSS?gid=1087";
		public static const TOP_25_IN_NICKELODEON:String = "http://rss.netflix.com/Top25RSS?gid=1088";
		public static const TOP_25_IN_TV_MINISERIES:String = "http://rss.netflix.com/Top25RSS?gid=1090";
		public static const TOP_25_IN_ANIME_FEATURE_FILMS:String = "http://rss.netflix.com/Top25RSS?gid=1098";
		public static const TOP_25_IN_CONTEMPORARY_JAZZ:String = "http://rss.netflix.com/Top25RSS?gid=1100";
		public static const TOP_25_IN_CURRENT_ROCCHI_PICKS:String = "http://rss.netflix.com/Top25RSS?gid=1115";
		public static const TOP_25_IN_DO_NOT_MERCH:String = "http://rss.netflix.com/Top25RSS?gid=1116";
		public static const TOP_25_IN_TEEN_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=1126";
		public static const TOP_25_IN_JUDAICA:String = "http://rss.netflix.com/Top25RSS?gid=1132";
		public static const TOP_25_IN_ANIME_ACTION:String = "http://rss.netflix.com/Top25RSS?gid=1146";
		public static const TOP_25_IN_ANIME_SCI_FI:String = "http://rss.netflix.com/Top25RSS?gid=1147";
		public static const TOP_25_IN_ANIME_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=1148";
		public static const TOP_25_IN_ANIME_DRAMA:String = "http://rss.netflix.com/Top25RSS?gid=1149";
		public static const TOP_25_IN_ANIME_COMEDY:String = "http://rss.netflix.com/Top25RSS?gid=1150";
		public static const TOP_25_IN_KIDS_ANIME:String = "http://rss.netflix.com/Top25RSS?gid=1151";
		public static const TOP_25_IN_ANIME_SERIES:String = "http://rss.netflix.com/Top25RSS?gid=1152";
		public static const TOP_25_IN_ANIME_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=1153";
		public static const TOP_25_IN_FAMILY_ADVENTURES:String = "http://rss.netflix.com/Top25RSS?gid=1173";
		public static const TOP_25_IN_COMING_OF_AGE:String = "http://rss.netflix.com/Top25RSS?gid=1179";
		public static const TOP_25_IN_CLASSIC_JAZZ:String = "http://rss.netflix.com/Top25RSS?gid=1193";
		public static const TOP_25_IN_MOCKUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1194";
		public static const TOP_25_IN_SOCIAL_ISSUE_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=1206";
		public static const TOP_25_IN_JAZZ_GREATS:String = "http://rss.netflix.com/Top25RSS?gid=1230";
		public static const TOP_25_IN_MADE_FOR_TV_MOVIES:String = "http://rss.netflix.com/Top25RSS?gid=1272";
		public static const TOP_25_IN_SCI_FI_CULT_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=1285";
		public static const TOP_25_IN_HEIST_FILMS:String = "http://rss.netflix.com/Top25RSS?gid=1288";
		public static const TOP_25_IN_SUPER_SWASHBUCKLERS:String = "http://rss.netflix.com/Top25RSS?gid=1289";
		public static const TOP_25_IN_DRAMAS_BASED_ON_THE_BOOK:String = "http://rss.netflix.com/Top25RSS?gid=1291";
		public static const TOP_25_IN_DRAMAS_BASED_ON_REAL_LIFE:String = "http://rss.netflix.com/Top25RSS?gid=1293";
		public static const TOP_25_IN_CULT_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=1296";
		public static const TOP_25_IN_TV_SCIENCE_AND_NATURE:String = "http://rss.netflix.com/Top25RSS?gid=1311";
		public static const TOP_25_IN_TV_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1312";
		public static const TOP_25_IN_INDIE_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1318";
		public static const TOP_25_IN_POLITICAL_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1319";
		public static const TOP_25_IN_TRAVEL_AND_ADVENTURE_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1320";
		public static const TOP_25_IN_SOCIAL_AND_CULTURAL_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1321";
		public static const TOP_25_IN_FAMILY_ANIMATION:String = "http://rss.netflix.com/Top25RSS?gid=1325";
		public static const TOP_25_IN_ANIMATION_FOR_GROWN_UPS:String = "http://rss.netflix.com/Top25RSS?gid=1326";
		public static const TOP_25_IN_SCI_FI_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=1327";
		public static const TOP_25_IN_SCI_FI_ADVENTURE:String = "http://rss.netflix.com/Top25RSS?gid=1328";
		public static const TOP_25_IN_SUPERNATURAL_SCI_FI:String = "http://rss.netflix.com/Top25RSS?gid=1329";
		public static const TOP_25_IN_ADVENTURES:String = "http://rss.netflix.com/Top25RSS?gid=1330";
		public static const TOP_25_IN_INDIE_GAY_AND_LESBIAN:String = "http://rss.netflix.com/Top25RSS?gid=1335";
		public static const TOP_25_IN_INDIE_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=1336";
		public static const TOP_25_IN_INDIE_SUSPENSE_AND_THRILLER:String = "http://rss.netflix.com/Top25RSS?gid=1337";
		public static const TOP_25_IN_SLAPSTICK:String = "http://rss.netflix.com/Top25RSS?gid=1338";
		public static const TOP_25_IN_LESBIAN:String = "http://rss.netflix.com/Top25RSS?gid=1344";
		public static const TOP_25_IN_BISEXUAL:String = "http://rss.netflix.com/Top25RSS?gid=1345";
		public static const TOP_25_IN_POLITICAL_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=1349";
		public static const TOP_25_IN_KIDS_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=1372";
		public static const TOP_25_IN_FAMILY_SCI_FI_AND_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=1385";
		public static const TOP_25_IN_DINOSAURS:String = "http://rss.netflix.com/Top25RSS?gid=1386";
		public static const TOP_25_IN_HBO_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1409";
		public static const TOP_25_IN_PBS_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=1412";
		public static const TOP_25_IN_ESPIONAGE_ACTION:String = "http://rss.netflix.com/Top25RSS?gid=1419";
		public static const TOP_25_IN_SCI_FI_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=1420";
		public static const TOP_25_IN_GAY:String = "http://rss.netflix.com/Top25RSS?gid=1433";
		public static const TOP_25_IN_AGES_0_2:String = "http://rss.netflix.com/Top25RSS?gid=2050";
		public static const TOP_25_IN_AGES_2_4:String = "http://rss.netflix.com/Top25RSS?gid=2051";
		public static const TOP_25_IN_AGES_5_7:String = "http://rss.netflix.com/Top25RSS?gid=2052";
		public static const TOP_25_IN_AGES_8_10:String = "http://rss.netflix.com/Top25RSS?gid=2053";
		public static const TOP_25_IN_AGES_11_12:String = "http://rss.netflix.com/Top25RSS?gid=2054";
		public static const TOP_25_IN_KIDS_INSPIRATIONAL:String = "http://rss.netflix.com/Top25RSS?gid=2061";
		public static const TOP_25_IN_FAITH_AND_SPIRITUALITY:String = "http://rss.netflix.com/Top25RSS?gid=2108";
		public static const TOP_25_IN_FAITH_AND_SPIRITUALITY_FEATURE_FILMS:String = "http://rss.netflix.com/Top25RSS?gid=2109";
		public static const TOP_25_IN_RELIGIOUS_AND_MYTHIC_EPICS:String = "http://rss.netflix.com/Top25RSS?gid=2110";
		public static const TOP_25_IN_RELIGIOUS_COMEDIES_AND_SATIRES:String = "http://rss.netflix.com/Top25RSS?gid=2111";
		public static const TOP_25_IN_INSPIRATIONAL_STORIES:String = "http://rss.netflix.com/Top25RSS?gid=2112";
		public static const TOP_25_IN_LATINO_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2113";
		public static const TOP_25_IN_INSPIRATIONAL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2115";
		public static const TOP_25_IN_INSPIRATIONAL_ROCK_AND_POP:String = "http://rss.netflix.com/Top25RSS?gid=2116";
		public static const TOP_25_IN_SACRED_FOLK_AND_TRADITIONAL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2117";
		public static const TOP_25_IN_INSPIRATIONAL_SING_ALONGS:String = "http://rss.netflix.com/Top25RSS?gid=2118";
		public static const TOP_25_IN_INSPIRATIONAL_STORIES_FOR_KIDS:String = "http://rss.netflix.com/Top25RSS?gid=2121";
		public static const TOP_25_IN_MINDFULNESS_AND_PRAYER:String = "http://rss.netflix.com/Top25RSS?gid=2122";
		public static const TOP_25_IN_MEDITATION_AND_RELAXATION:String = "http://rss.netflix.com/Top25RSS?gid=2123";
		public static const TOP_25_IN_HEALING_AND_REIKI:String = "http://rss.netflix.com/Top25RSS?gid=2124";
		public static const TOP_25_IN_PRAYER_AND_SPIRITUAL_GROWTH:String = "http://rss.netflix.com/Top25RSS?gid=2125";
		public static const TOP_25_IN_INSPIRATIONAL_BIOGRAPHIES:String = "http://rss.netflix.com/Top25RSS?gid=2129";
		public static const TOP_25_IN_RELIGION_AND_MYTHOLOGY_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=2130";
		public static const TOP_25_IN_SELF_DEFENSE:String = "http://rss.netflix.com/Top25RSS?gid=2136";
		public static const TOP_25_IN_TENNIS:String = "http://rss.netflix.com/Top25RSS?gid=2137";
		public static const TOP_25_IN_EXTREME_MOTORSPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2138";
		public static const TOP_25_IN_BMX_AND_EXTREME_BIKING:String = "http://rss.netflix.com/Top25RSS?gid=2139";
		public static const TOP_25_IN_EXTREME_COMBAT_AND_MIXED_MARTIAL_ARTS:String = "http://rss.netflix.com/Top25RSS?gid=2140";
		public static const TOP_25_IN_EXTREME_SNOW_AND_ICE_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2141";
		public static const TOP_25_IN_STUNTS_AND_GENERAL_MAYHEM:String = "http://rss.netflix.com/Top25RSS?gid=2144";
		public static const TOP_25_IN_MOUNTAINEERING_AND_CLIMBING:String = "http://rss.netflix.com/Top25RSS?gid=2146";
		public static const TOP_25_IN_EXTREME_SPORTS_COMPILATIONS:String = "http://rss.netflix.com/Top25RSS?gid=2147";
		public static const TOP_25_IN_WRESTLING:String = "http://rss.netflix.com/Top25RSS?gid=2148";
		public static const TOP_25_IN_PILATES_AND_FITNESS_BALL:String = "http://rss.netflix.com/Top25RSS?gid=2150";
		public static const TOP_25_IN_STEP_AEROBICS_WORKOUTS:String = "http://rss.netflix.com/Top25RSS?gid=2151";
		public static const TOP_25_IN_SKATEBOARDING:String = "http://rss.netflix.com/Top25RSS?gid=2152";
		public static const TOP_25_IN_BOXING:String = "http://rss.netflix.com/Top25RSS?gid=2154";
		public static const TOP_25_IN_GENERAL_MARTIAL_ARTS:String = "http://rss.netflix.com/Top25RSS?gid=2155";
		public static const TOP_25_IN_KARATE:String = "http://rss.netflix.com/Top25RSS?gid=2156";
		public static const TOP_25_IN_KUNG_FU:String = "http://rss.netflix.com/Top25RSS?gid=2157";
		public static const TOP_25_IN_AUTO_RACING:String = "http://rss.netflix.com/Top25RSS?gid=2158";
		public static const TOP_25_IN_MOTORCYCLES_AND_MOTOCROSS:String = "http://rss.netflix.com/Top25RSS?gid=2159";
		public static const TOP_25_IN_SNOW_AND_ICE_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2161";
		public static const TOP_25_IN_MISCELLANEOUS_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2163";
		public static const TOP_25_IN_SKIING:String = "http://rss.netflix.com/Top25RSS?gid=2164";
		public static const TOP_25_IN_CAR_CULTURE:String = "http://rss.netflix.com/Top25RSS?gid=2165";
		public static const TOP_25_IN_SPORTS_STORIES:String = "http://rss.netflix.com/Top25RSS?gid=2166";
		public static const TOP_25_IN_CYCLING:String = "http://rss.netflix.com/Top25RSS?gid=2167";
		public static const TOP_25_IN_OTHER_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2168";
		public static const TOP_25_IN_HORSE_RACING:String = "http://rss.netflix.com/Top25RSS?gid=2169";
		public static const TOP_25_IN_BODYBUILDING:String = "http://rss.netflix.com/Top25RSS?gid=2170";
		public static const TOP_25_IN_OUTDOOR_AND_MOUNTAIN_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2172";
		public static const TOP_25_IN_FISHING:String = "http://rss.netflix.com/Top25RSS?gid=2173";
		public static const TOP_25_IN_MOUNTAIN_BIKING:String = "http://rss.netflix.com/Top25RSS?gid=2174";
		public static const TOP_25_IN_BOATING_AND_SAILING:String = "http://rss.netflix.com/Top25RSS?gid=2177";
		public static const TOP_25_IN_OTHER_WATER_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2178";
		public static const TOP_25_IN_HUNTING:String = "http://rss.netflix.com/Top25RSS?gid=2179";
		public static const TOP_25_IN_KIDS_FITNESS:String = "http://rss.netflix.com/Top25RSS?gid=2180";
		public static const TOP_25_IN_ABS_GLUTES_AND_MORE:String = "http://rss.netflix.com/Top25RSS?gid=2183";
		public static const TOP_25_IN_CARDIO_AND_AEROBICS:String = "http://rss.netflix.com/Top25RSS?gid=2184";
		public static const TOP_25_IN_MARTIAL_ARTS_AND_BOXING_WORKOUTS:String = "http://rss.netflix.com/Top25RSS?gid=2186";
		public static const TOP_25_IN_SPORTS_AND_FITNESS:String = "http://rss.netflix.com/Top25RSS?gid=2190";
		public static const TOP_25_IN_HOMEWORK_HELP:String = "http://rss.netflix.com/Top25RSS?gid=2192";
		public static const TOP_25_IN_TELEVISION:String = "http://rss.netflix.com/Top25RSS?gid=2197";
		public static const TOP_25_IN_BRITISH_TV_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2198";
		public static const TOP_25_IN_FOREIGN_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2204";
		public static const TOP_25_IN_FOREIGN_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=2205";
		public static const TOP_25_IN_TV_ACTION_AND_ADVENTURE:String = "http://rss.netflix.com/Top25RSS?gid=2210";
		public static const TOP_25_IN_TV_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=2211";
		public static const TOP_25_IN_CLASSIC_TV_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2212";
		public static const TOP_25_IN_CLASSIC_TV_SCI_FI_AND_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=2213";
		public static const TOP_25_IN_CLASSIC_TV_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2214";
		public static const TOP_25_IN_FOREIGN_TELEVISION:String = "http://rss.netflix.com/Top25RSS?gid=2215";
		public static const TOP_25_IN_FOREIGN_THRILLERS:String = "http://rss.netflix.com/Top25RSS?gid=2216";
		public static const TOP_25_IN_AFRICA:String = "http://rss.netflix.com/Top25RSS?gid=2218";
		public static const TOP_25_IN_BRITISH_TV:String = "http://rss.netflix.com/Top25RSS?gid=2221";
		public static const TOP_25_IN_BRITISH_TV_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2222";
		public static const TOP_25_IN_SPECIAL_INTEREST:String = "http://rss.netflix.com/Top25RSS?gid=2223";
		public static const TOP_25_IN_CAREER_AND_FINANCE:String = "http://rss.netflix.com/Top25RSS?gid=2225";
		public static const TOP_25_IN_LANGUAGE_INSTRUCTION:String = "http://rss.netflix.com/Top25RSS?gid=2231";
		public static const TOP_25_IN_MIND_AND_BODY:String = "http://rss.netflix.com/Top25RSS?gid=2232";
		public static const TOP_25_IN_POKER_AND_GAMBLING:String = "http://rss.netflix.com/Top25RSS?gid=2233";
		public static const TOP_25_IN_TECHNOLOGY:String = "http://rss.netflix.com/Top25RSS?gid=2234";
		public static const TOP_25_IN_THEATER_ARTS:String = "http://rss.netflix.com/Top25RSS?gid=2235";
		public static const TOP_25_IN_PHOTOGRAPHY:String = "http://rss.netflix.com/Top25RSS?gid=2236";
		public static const TOP_25_IN_COMPUTER_ANIMATION:String = "http://rss.netflix.com/Top25RSS?gid=2237";
		public static const TOP_25_IN_PAINTING:String = "http://rss.netflix.com/Top25RSS?gid=2238";
		public static const TOP_25_IN_SCULPTURE:String = "http://rss.netflix.com/Top25RSS?gid=2240";
		public static const TOP_25_IN_TAP_AND_JAZZ_DANCE:String = "http://rss.netflix.com/Top25RSS?gid=2242";
		public static const TOP_25_IN_BALLET_AND_MODERN_DANCE:String = "http://rss.netflix.com/Top25RSS?gid=2243";
		public static const TOP_25_IN_BELLYDANCE:String = "http://rss.netflix.com/Top25RSS?gid=2245";
		public static const TOP_25_IN_HIP_HOP_AND_CONTEMPORARY_DANCE:String = "http://rss.netflix.com/Top25RSS?gid=2246";
		public static const TOP_25_IN_LATIN_AND_BALLROOM_DANCE:String = "http://rss.netflix.com/Top25RSS?gid=2247";
		public static const TOP_25_IN_STYLE_AND_BEAUTY:String = "http://rss.netflix.com/Top25RSS?gid=2249";
		public static const TOP_25_IN_LOW_IMPACT_WORKOUTS:String = "http://rss.netflix.com/Top25RSS?gid=2250";
		public static const TOP_25_IN_FOOD_STORIES:String = "http://rss.netflix.com/Top25RSS?gid=2253";
		public static const TOP_25_IN_COOKING_INSTRUCTION:String = "http://rss.netflix.com/Top25RSS?gid=2254";
		public static const TOP_25_IN_WINE_AND_BEVERAGE_APPRECIATION:String = "http://rss.netflix.com/Top25RSS?gid=2255";
		public static const TOP_25_IN_AFRICAN_AMERICAN_ACTION:String = "http://rss.netflix.com/Top25RSS?gid=2256";
		public static const TOP_25_IN_WORLD_DANCE:String = "http://rss.netflix.com/Top25RSS?gid=2258";
		public static const TOP_25_IN_DANCE:String = "http://rss.netflix.com/Top25RSS?gid=2259";
		public static const TOP_25_IN_MAGIC_AND_ILLUSION:String = "http://rss.netflix.com/Top25RSS?gid=2260";
		public static const TOP_25_IN_HOME_IMPROVEMENT:String = "http://rss.netflix.com/Top25RSS?gid=2264";
		public static const TOP_25_IN_PETS:String = "http://rss.netflix.com/Top25RSS?gid=2266";
		public static const TOP_25_IN_ENGLISH_AND_LANGUAGE_ARTS:String = "http://rss.netflix.com/Top25RSS?gid=2267";
		public static const TOP_25_IN_HISTORY_AND_SOCIAL_STUDIES:String = "http://rss.netflix.com/Top25RSS?gid=2268";
		public static const TOP_25_IN_MATH:String = "http://rss.netflix.com/Top25RSS?gid=2269";
		public static const TOP_25_IN_SCIENCE:String = "http://rss.netflix.com/Top25RSS?gid=2270";
		public static const TOP_25_IN_LATINO_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2274";
		public static const TOP_25_IN_ENTERTAINING:String = "http://rss.netflix.com/Top25RSS?gid=2277";
		public static const TOP_25_IN_HEALTHY_LIVING:String = "http://rss.netflix.com/Top25RSS?gid=2278";
		public static const TOP_25_IN_PREGNANCY_AND_PARENTING:String = "http://rss.netflix.com/Top25RSS?gid=2279";
		public static const TOP_25_IN_COMPUTERS_AND_ELECTRONICS:String = "http://rss.netflix.com/Top25RSS?gid=2290";
		public static const TOP_25_IN_GEOGRAPHIC_INFORMATION_SYSTEMS:String = "http://rss.netflix.com/Top25RSS?gid=2291";
		public static const TOP_25_IN_PERFORMANCE_ART_AND_SPOKEN_WORD:String = "http://rss.netflix.com/Top25RSS?gid=2293";
		public static const TOP_25_IN_HOME_AND_GARDEN:String = "http://rss.netflix.com/Top25RSS?gid=2294";
		public static const TOP_25_IN_THEATRICAL_PERFORMANCES:String = "http://rss.netflix.com/Top25RSS?gid=2295";
		public static const TOP_25_IN_SHAKESPEARE:String = "http://rss.netflix.com/Top25RSS?gid=2296";
		public static const TOP_25_IN_MARTIAL_ARTS_BOXING_AND_WRESTLING:String = "http://rss.netflix.com/Top25RSS?gid=2307";
		public static const TOP_25_IN_HOBBIES_AND_GAMES:String = "http://rss.netflix.com/Top25RSS?gid=2309";
		public static const TOP_25_IN_MUSIC_AND_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2310";
		public static const TOP_25_IN_CLASSICAL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2311";
		public static const TOP_25_IN_WORLD_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2312";
		public static const TOP_25_IN_JAZZ_AND_EASY_LISTENING:String = "http://rss.netflix.com/Top25RSS?gid=2313";
		public static const TOP_25_IN_MUSIC_LESSONS:String = "http://rss.netflix.com/Top25RSS?gid=2315";
		public static const TOP_25_IN_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2316";
		public static const TOP_25_IN_ROCK_AND_POP:String = "http://rss.netflix.com/Top25RSS?gid=2317";
		public static const TOP_25_IN_REGGAE:String = "http://rss.netflix.com/Top25RSS?gid=2318";
		public static const TOP_25_IN_EUROPEAN_FOLK_AND_TRADITIONAL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2319";
		public static const TOP_25_IN_CELTIC_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2320";
		public static const TOP_25_IN_ROCK_EN_ESPAÑOL:String = "http://rss.netflix.com/Top25RSS?gid=2321";
		public static const TOP_25_IN_BASS_LESSONS:String = "http://rss.netflix.com/Top25RSS?gid=2323";
		public static const TOP_25_IN_DRUM_LESSONS:String = "http://rss.netflix.com/Top25RSS?gid=2324";
		public static const TOP_25_IN_GUITAR_AND_BANJO_LESSONS:String = "http://rss.netflix.com/Top25RSS?gid=2325";
		public static const TOP_25_IN_PIANO_AND_KEYBOARD_LESSONS:String = "http://rss.netflix.com/Top25RSS?gid=2327";
		public static const TOP_25_IN_VOICE_LESSONS:String = "http://rss.netflix.com/Top25RSS?gid=2328";
		public static const TOP_25_IN_GENERAL_STRENGTH_AND_FLEXIBILITY:String = "http://rss.netflix.com/Top25RSS?gid=2329";
		public static const TOP_25_IN_CLASSICAL_CHORAL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2330";
		public static const TOP_25_IN_CLASSICAL_INSTRUMENTAL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2331";
		public static const TOP_25_IN_BRAZILIAN_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2332";
		public static const TOP_25_IN_LATIN_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2333";
		public static const TOP_25_IN_LATIN_POP:String = "http://rss.netflix.com/Top25RSS?gid=2334";
		public static const TOP_25_IN_TRADITIONAL_LATIN_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2335";
		public static const TOP_25_IN_REGGAETON:String = "http://rss.netflix.com/Top25RSS?gid=2336";
		public static const TOP_25_IN_OPERA_AND_OPERETTA:String = "http://rss.netflix.com/Top25RSS?gid=2337";
		public static const TOP_25_IN_VOCAL_JAZZ:String = "http://rss.netflix.com/Top25RSS?gid=2339";
		public static const TOP_25_IN_SWING_AND_BIG_BAND:String = "http://rss.netflix.com/Top25RSS?gid=2340";
		public static const TOP_25_IN_CLASSIC_MOVIE_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2341";
		public static const TOP_25_IN_CLASSIC_STAGE_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2342";
		public static const TOP_25_IN_MISCELLANEOUS_MUSIC_LESSONS:String = "http://rss.netflix.com/Top25RSS?gid=2348";
		public static const TOP_25_IN_CONTEMPORARY_MOVIE_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2350";
		public static const TOP_25_IN_CONTEMPORARY_STAGE_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2351";
		public static const TOP_25_IN_AMERICAN_FOLK_AND_BLUEGRASS:String = "http://rss.netflix.com/Top25RSS?gid=2352";
		public static const TOP_25_IN_HAWAIIAN_AND_POLYNESIAN_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2353";
		public static const TOP_25_IN_WORLD_FUSION:String = "http://rss.netflix.com/Top25RSS?gid=2354";
		public static const TOP_25_IN_AFRICAN_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2355";
		public static const TOP_25_IN_MOTORSPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2356";
		public static const TOP_25_IN_GARDENING:String = "http://rss.netflix.com/Top25RSS?gid=2357";
		public static const TOP_25_IN_ARGENTINA:String = "http://rss.netflix.com/Top25RSS?gid=2358";
		public static const TOP_25_IN_ROCK_AND_ROLL_OLDIES:String = "http://rss.netflix.com/Top25RSS?gid=2359";
		public static const TOP_25_IN_GOTH_AND_INDUSTRIAL:String = "http://rss.netflix.com/Top25RSS?gid=2360";
		public static const TOP_25_IN_DISCO:String = "http://rss.netflix.com/Top25RSS?gid=2361";
		public static const TOP_25_IN_MUST_SEE_CONCERTS:String = "http://rss.netflix.com/Top25RSS?gid=2364";
		public static const TOP_25_IN_SINGER_SONGWRITERS:String = "http://rss.netflix.com/Top25RSS?gid=2365";
		public static const TOP_25_IN_MUST_SEE_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2366";
		public static const TOP_25_IN_URBAN_AND_DANCE:String = "http://rss.netflix.com/Top25RSS?gid=2367";
		public static const TOP_25_IN_CLASSIC_RANDB_AND_SOUL:String = "http://rss.netflix.com/Top25RSS?gid=2368";
		public static const TOP_25_IN_AFRO_CUBAN_AND_LATIN_JAZZ:String = "http://rss.netflix.com/Top25RSS?gid=2370";
		public static const TOP_25_IN_AFRICAN_AMERICAN_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2372";
		public static const TOP_25_IN_AFRICAN_AMERICAN_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=2373";
		public static const TOP_25_IN_AFRICAN_AMERICAN_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2374";
		public static const TOP_25_IN_AFRICAN_AMERICAN_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=2375";
		public static const TOP_25_IN_ASIAN_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2378";
		public static const TOP_25_IN_SACRED_CLASSICAL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2394";
		public static const TOP_25_IN_BASEBALL:String = "http://rss.netflix.com/Top25RSS?gid=2395";
		public static const TOP_25_IN_FOOTBALL:String = "http://rss.netflix.com/Top25RSS?gid=2396";
		public static const TOP_25_IN_EXTREME_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2397";
		public static const TOP_25_IN_KARAOKE:String = "http://rss.netflix.com/Top25RSS?gid=2399";
		public static const TOP_25_IN_GOSPEL_MUSIC:String = "http://rss.netflix.com/Top25RSS?gid=2400";
		public static const TOP_25_IN_NEW_AGE:String = "http://rss.netflix.com/Top25RSS?gid=2402";
		public static const TOP_25_IN_VOCAL_POP:String = "http://rss.netflix.com/Top25RSS?gid=2403";
		public static const TOP_25_IN_FOREIGN_MUSICALS:String = "http://rss.netflix.com/Top25RSS?gid=2404";
		public static const TOP_25_IN_SHOW_TUNES:String = "http://rss.netflix.com/Top25RSS?gid=2405";
		public static const TOP_25_IN_HARD_ROCK_AND_HEAVY_METAL:String = "http://rss.netflix.com/Top25RSS?gid=2406";
		public static const TOP_25_IN_POP:String = "http://rss.netflix.com/Top25RSS?gid=2407";
		public static const TOP_25_IN_CLASSIC_ROCK:String = "http://rss.netflix.com/Top25RSS?gid=2408";
		public static const TOP_25_IN_MODERN_AND_ALTERNATIVE_ROCK:String = "http://rss.netflix.com/Top25RSS?gid=2409";
		public static const TOP_25_IN_ROCKUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=2410";
		public static const TOP_25_IN_DANCE_AND_ELECTRONICA:String = "http://rss.netflix.com/Top25RSS?gid=2411";
		public static const TOP_25_IN_RAP_AND_HIP_HOP:String = "http://rss.netflix.com/Top25RSS?gid=2412";
		public static const TOP_25_IN_BLAXPLOITATION:String = "http://rss.netflix.com/Top25RSS?gid=2414";
		public static const TOP_25_IN_FOOD_AND_WINE:String = "http://rss.netflix.com/Top25RSS?gid=2415";
		public static const TOP_25_IN_ART_AND_DESIGN:String = "http://rss.netflix.com/Top25RSS?gid=2416";
		public static const TOP_25_IN_FOREIGN_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=2419";
		public static const TOP_25_IN_OLYMPICS_AND_OTHER_GAMES:String = "http://rss.netflix.com/Top25RSS?gid=2420";
		public static const TOP_25_IN_SPORTS_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2421";
		public static const TOP_25_IN_SPORTS_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2422";
		public static const TOP_25_IN_TRIUMPH_OF_THE_UNDERDOGS:String = "http://rss.netflix.com/Top25RSS?gid=2424";
		public static const TOP_25_IN_RELIGIOUS_AND_SPIRITUAL_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2425";
		public static const TOP_25_IN_SPIRITUAL_MYSTERIES:String = "http://rss.netflix.com/Top25RSS?gid=2426";
		public static const TOP_25_IN_MISCELLANEOUS_HOBBIES_AND_GAMES:String = "http://rss.netflix.com/Top25RSS?gid=2427";
		public static const TOP_25_IN_BLUES:String = "http://rss.netflix.com/Top25RSS?gid=2436";
		public static const TOP_25_IN_CONTEMPORARY_RANDB:String = "http://rss.netflix.com/Top25RSS?gid=2437";
		public static const TOP_25_IN_COUNTRY_AND_WESTERN_AND_FOLK:String = "http://rss.netflix.com/Top25RSS?gid=2439";
		public static const TOP_25_IN_CLASSIC_COUNTRY_AND_WESTERN:String = "http://rss.netflix.com/Top25RSS?gid=2440";
		public static const TOP_25_IN_NEW_COUNTRY:String = "http://rss.netflix.com/Top25RSS?gid=2441";
		public static const TOP_25_IN_BLU_RAY:String = "http://rss.netflix.com/Top25RSS?gid=2444";
		public static const TOP_25_IN_GOLF:String = "http://rss.netflix.com/Top25RSS?gid=2447";
		public static const TOP_25_IN_ICE_HOCKEY:String = "http://rss.netflix.com/Top25RSS?gid=2448";
		public static const TOP_25_IN_SNOWBOARDING:String = "http://rss.netflix.com/Top25RSS?gid=2449";
		public static const TOP_25_IN_SOCCER:String = "http://rss.netflix.com/Top25RSS?gid=2450";
		public static const TOP_25_IN_SPORTS_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=2451";
		public static const TOP_25_IN_WOMEN_IN_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2452";
		public static const TOP_25_IN_WATER_SPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2453";
		public static const TOP_25_IN_SURFING_AND_BOARDSPORTS:String = "http://rss.netflix.com/Top25RSS?gid=2454";
		public static const TOP_25_IN_WORKOUTS:String = "http://rss.netflix.com/Top25RSS?gid=2455";
		public static const TOP_25_IN_DANCE_WORKOUTS:String = "http://rss.netflix.com/Top25RSS?gid=2456";
		public static const TOP_25_IN_PREGNANCY_AND_POST_NATAL_FITNESS:String = "http://rss.netflix.com/Top25RSS?gid=2457";
		public static const TOP_25_IN_TAI_CHI_AND_QIGONG:String = "http://rss.netflix.com/Top25RSS?gid=2458";
		public static const TOP_25_IN_YOGA:String = "http://rss.netflix.com/Top25RSS?gid=2459";
		public static const TOP_25_IN_BASKETBALL:String = "http://rss.netflix.com/Top25RSS?gid=2460";
		public static const TOP_25_IN_TV_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2470";
		public static const TOP_25_IN_TV_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2471";
		public static const TOP_25_IN_MUST_SEE_TV_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2472";
		public static const TOP_25_IN_TV_ANIMATED_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2473";
		public static const TOP_25_IN_TV_SITCOMS:String = "http://rss.netflix.com/Top25RSS?gid=2474";
		public static const TOP_25_IN_TV_SKETCH_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2475";
		public static const TOP_25_IN_MUST_SEE_TV_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2476";
		public static const TOP_25_IN_TV_COURTROOM_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2477";
		public static const TOP_25_IN_TV_CRIME_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2478";
		public static const TOP_25_IN_TV_DRAMEDY:String = "http://rss.netflix.com/Top25RSS?gid=2479";
		public static const TOP_25_IN_TV_FAMILY_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2480";
		public static const TOP_25_IN_TV_MEDICAL_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2481";
		public static const TOP_25_IN_TV_SOAPS:String = "http://rss.netflix.com/Top25RSS?gid=2482";
		public static const TOP_25_IN_TV_TEEN_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2483";
		public static const TOP_25_IN_FOREIGN_CLASSIC_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2484";
		public static const TOP_25_IN_FOREIGN_CLASSICS:String = "http://rss.netflix.com/Top25RSS?gid=2485";
		public static const TOP_25_IN_TV_REALITY_PROGRAMMING:String = "http://rss.netflix.com/Top25RSS?gid=2486";
		public static const TOP_25_IN_FOREIGN_ART_HOUSE:String = "http://rss.netflix.com/Top25RSS?gid=2487";
		public static const TOP_25_IN_TV_SCI_FI_AND_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=2488";
		public static const TOP_25_IN_TV_VARIETY_AND_TALK_SHOWS:String = "http://rss.netflix.com/Top25RSS?gid=2489";
		public static const TOP_25_IN_TV_WAR_AND_POLITICS:String = "http://rss.netflix.com/Top25RSS?gid=2490";
		public static const TOP_25_IN_TV_WESTERNS:String = "http://rss.netflix.com/Top25RSS?gid=2491";
		public static const TOP_25_IN_FOREIGN_CLASSIC_COMEDIES:String = "http://rss.netflix.com/Top25RSS?gid=2492";
		public static const TOP_25_IN_FOREIGN_SILENT_FILMS:String = "http://rss.netflix.com/Top25RSS?gid=2493";
		public static const TOP_25_IN_FOREIGN_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2494";
		public static const TOP_25_IN_FOREIGN_GAY_AND_LESBIAN:String = "http://rss.netflix.com/Top25RSS?gid=2495";
		public static const TOP_25_IN_ASIAN_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=2496";
		public static const TOP_25_IN_ITALIAN_HORROR:String = "http://rss.netflix.com/Top25RSS?gid=2497";
		public static const TOP_25_IN_FOREIGN_MUST_SEE:String = "http://rss.netflix.com/Top25RSS?gid=2498";
		public static const TOP_25_IN_FOREIGN_CHILDREN_AND_FAMILY:String = "http://rss.netflix.com/Top25RSS?gid=2499";
		public static const TOP_25_IN_FOREIGN_ACTION_AND_ADVENTURE:String = "http://rss.netflix.com/Top25RSS?gid=2500";
		public static const TOP_25_IN_TV_MYSTERIES:String = "http://rss.netflix.com/Top25RSS?gid=2501";
		public static const TOP_25_IN_FOREIGN_SCI_FI_AND_FANTASY:String = "http://rss.netflix.com/Top25RSS?gid=2502";
		public static const TOP_25_IN_FOREIGN:String = "http://rss.netflix.com/Top25RSS?gid=2514";
		public static const TOP_25_IN_AUSTRALIA_AND_NEW_ZEALAND:String = "http://rss.netflix.com/Top25RSS?gid=2515";
		public static const TOP_25_IN_BELGIUM:String = "http://rss.netflix.com/Top25RSS?gid=2516";
		public static const TOP_25_IN_BRAZIL:String = "http://rss.netflix.com/Top25RSS?gid=2517";
		public static const TOP_25_IN_CHINA:String = "http://rss.netflix.com/Top25RSS?gid=2519";
		public static const TOP_25_IN_CZECH_REPUBLIC:String = "http://rss.netflix.com/Top25RSS?gid=2520";
		public static const TOP_25_IN_EASTERN_EUROPE:String = "http://rss.netflix.com/Top25RSS?gid=2521";
		public static const TOP_25_IN_FRANCE:String = "http://rss.netflix.com/Top25RSS?gid=2522";
		public static const TOP_25_IN_GERMANY:String = "http://rss.netflix.com/Top25RSS?gid=2523";
		public static const TOP_25_IN_GREECE:String = "http://rss.netflix.com/Top25RSS?gid=2524";
		public static const TOP_25_IN_HONG_KONG:String = "http://rss.netflix.com/Top25RSS?gid=2525";
		public static const TOP_25_IN_INDIA:String = "http://rss.netflix.com/Top25RSS?gid=2526";
		public static const TOP_25_IN_BOLLYWOOD:String = "http://rss.netflix.com/Top25RSS?gid=2527";
		public static const TOP_25_IN_IRAN:String = "http://rss.netflix.com/Top25RSS?gid=2528";
		public static const TOP_25_IN_ISRAEL:String = "http://rss.netflix.com/Top25RSS?gid=2529";
		public static const TOP_25_IN_ITALY:String = "http://rss.netflix.com/Top25RSS?gid=2530";
		public static const TOP_25_IN_JAPAN:String = "http://rss.netflix.com/Top25RSS?gid=2531";
		public static const TOP_25_IN_KOREA:String = "http://rss.netflix.com/Top25RSS?gid=2532";
		public static const TOP_25_IN_LATIN_AMERICA:String = "http://rss.netflix.com/Top25RSS?gid=2533";
		public static const TOP_25_IN_MEXICO:String = "http://rss.netflix.com/Top25RSS?gid=2534";
		public static const TOP_25_IN_MIDDLE_EAST:String = "http://rss.netflix.com/Top25RSS?gid=2535";
		public static const TOP_25_IN_NETHERLANDS:String = "http://rss.netflix.com/Top25RSS?gid=2536";
		public static const TOP_25_IN_PHILIPPINES:String = "http://rss.netflix.com/Top25RSS?gid=2537";
		public static const TOP_25_IN_POLAND:String = "http://rss.netflix.com/Top25RSS?gid=2538";
		public static const TOP_25_IN_RUSSIA:String = "http://rss.netflix.com/Top25RSS?gid=2539";
		public static const TOP_25_IN_SCANDINAVIA:String = "http://rss.netflix.com/Top25RSS?gid=2540";
		public static const TOP_25_IN_SOUTHEAST_ASIA:String = "http://rss.netflix.com/Top25RSS?gid=2541";
		public static const TOP_25_IN_SPAIN:String = "http://rss.netflix.com/Top25RSS?gid=2542";
		public static const TOP_25_IN_THAILAND:String = "http://rss.netflix.com/Top25RSS?gid=2543";
		public static const TOP_25_IN_UNITED_KINGDOM:String = "http://rss.netflix.com/Top25RSS?gid=2544";
		public static const TOP_25_IN_ARABIC_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2545";
		public static const TOP_25_IN_BENGALI_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2547";
		public static const TOP_25_IN_CANTONESE_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2548";
		public static const TOP_25_IN_CZECH_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2549";
		public static const TOP_25_IN_DANISH_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2550";
		public static const TOP_25_IN_DUTCH_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2552";
		public static const TOP_25_IN_FARSI_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2553";
		public static const TOP_25_IN_FRENCH_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2554";
		public static const TOP_25_IN_GERMAN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2555";
		public static const TOP_25_IN_GREEK_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2556";
		public static const TOP_25_IN_GUJARATI_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2557";
		public static const TOP_25_IN_HEBREW_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2558";
		public static const TOP_25_IN_HUNGARIAN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2560";
		public static const TOP_25_IN_ITALIAN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2561";
		public static const TOP_25_IN_JAPANESE_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2563";
		public static const TOP_25_IN_KOREAN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2564";
		public static const TOP_25_IN_MALAYALAM_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2565";
		public static const TOP_25_IN_MANDARIN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2566";
		public static const TOP_25_IN_NORWEGIAN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2567";
		public static const TOP_25_IN_POLISH_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2568";
		public static const TOP_25_IN_PORTUGUESE_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2569";
		public static const TOP_25_IN_PUNJABI_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2570";
		public static const TOP_25_IN_RUSSIAN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2571";
		public static const TOP_25_IN_SERBO_CROATIAN_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2572";
		public static const TOP_25_IN_SPANISH_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2573";
		public static const TOP_25_IN_SWEDISH_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2574";
		public static const TOP_25_IN_TAGALOG_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2575";
		public static const TOP_25_IN_TAMIL_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2576";
		public static const TOP_25_IN_TELUGU_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2577";
		public static const TOP_25_IN_THAI_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2578";
		public static const TOP_25_IN_VIETNAMESE_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2580";
		public static const TOP_25_IN_FOREIGN_DOCUMENTARIES:String = "http://rss.netflix.com/Top25RSS?gid=2590";
		public static const TOP_25_IN_HINDI_LANGUAGE:String = "http://rss.netflix.com/Top25RSS?gid=2591";
		public static const TOP_25_IN_FOREIGN_STEAMY_ROMANCE:String = "http://rss.netflix.com/Top25RSS?gid=2594";
		public static const TOP_25_IN_THANKSGIVING:String = "http://rss.netflix.com/Top25RSS?gid=2597";
		public static const TOP_25_IN_HALLOWEEN:String = "http://rss.netflix.com/Top25RSS?gid=2598";
		public static const TOP_25_IN_VALENTINE:String = "http://rss.netflix.com/Top25RSS?gid=2599";
		public static const TOP_25_IN_EASTER:String = "http://rss.netflix.com/Top25RSS?gid=2600";
		public static const TOP_25_IN_4TH_JULY:String = "http://rss.netflix.com/Top25RSS?gid=2601";
		public static const TOP_25_IN_DRAMAS_BASED_ON_CLASSIC_LITERATURE:String = "http://rss.netflix.com/Top25RSS?gid=2607";
		public static const TOP_25_IN_DRAMAS_BASED_ON_CONTEMPORARY_LITERATURE:String = "http://rss.netflix.com/Top25RSS?gid=2608";
		public static const TOP_25_IN_DRAMAS_BASED_ON_BESTSELLERS:String = "http://rss.netflix.com/Top25RSS?gid=2609";
		public static const TOP_25_IN_MEDICAL_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2610";
		public static const TOP_25_IN_GAMBLING_DRAMAS:String = "http://rss.netflix.com/Top25RSS?gid=2611";
		public static const TOP_25_IN_20TH_CENTURY_PERIOD_PIECES:String = "http://rss.netflix.com/Top25RSS?gid=2612";
		public static const TOP_25_IN_PRE_20TH_CENTURY_PERIOD_PIECES:String = "http://rss.netflix.com/Top25RSS?gid=2613";
		public static const TOP_25_IN_LOGO:String = "http://rss.netflix.com/Top25RSS?gid=2618";
		public static const TOP_25_IN_FOREIGN_LANGUAGES:String = "http://rss.netflix.com/Top25RSS?gid=2620";
		public static const TOP_25_IN_FOREIGN_REGIONS:String = "http://rss.netflix.com/Top25RSS?gid=2621";
		public static const TOP_25_IN_MOVIE_STUDIOS:String = "http://rss.netflix.com/Top25RSS?gid=2622";
		public static const TOP_25_IN_FOX_HOME_ENTERTAINMENT:String = "http://rss.netflix.com/Top25RSS?gid=2623";
		public static const TOP_25_IN_PARAMOUNT_HOME_ENTERTAINMENT:String = "http://rss.netflix.com/Top25RSS?gid=2624";
		public static const TOP_25_IN_BUENA_VISTA_HOME_ENTERTAINMENT:String = "http://rss.netflix.com/Top25RSS?gid=2625";
		public static const TOP_25_IN_LIONSGATE_HOME_ENTERTAINMENT:String = "http://rss.netflix.com/Top25RSS?gid=2626";
		public static const TOP_25_IN_SONY_PICTURES_HOME_ENTERTAINMENT:String = "http://rss.netflix.com/Top25RSS?gid=2627";
		public static const TOP_25_IN_UNIVERSAL_STUDIOS_HOME_ENTERTAINMENT:String = "http://rss.netflix.com/Top25RSS?gid=2628";
		public static const TOP_25_IN_WARNER_HOME_VIDEO:String = "http://rss.netflix.com/Top25RSS?gid=2629";
		public static const TOP_25_IN_MIRAMAX:String = "http://rss.netflix.com/Top25RSS?gid=2630";
		
		
		
		
		//---------------------------------------------------------------------
		//
		// Protected Static Consts
		//
		//---------------------------------------------------------------------
		protected static const TOP_100_URL:String = "http://rss.netflix.com/Top100RSS";
		protected static const NEW_RELEASES_URL:String = "http://rss.netflix.com/NewReleasesRSS";
		protected static const NEW_INSTANT_URL:String = "http://www.netflix.com/NewWatchInstantlyRSS";
		protected static const FEEDS_URL:String = "http://rss.netflix.com/Top25RSS";
		
		//---------------------------------------------------------------------
		//
		// Private Properties
		//
		//---------------------------------------------------------------------
		private var _ratingService:RatingService;
		private var _urlLoader:URLLoader;
		
		private var _lastFeed:String;
		private var _lastFeedReturn:Array;
		//---------------------------------------------------------------------
		//
		// Public Methods
		//
		//---------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */		
		override public function send(parameters:ParamsBase = null):void
		{
			super.send(parameters);
			
			//run service based on type
			switch(type)
			{
				case TOP_100_SERVICE:
					top100Service( parameters );
					break;
				case NEW_RELEASES_SERVICE:
					newReleasesService( parameters );
					break;
				case NEW_INSTANT_SERVICE:
					newInstantService( parameters );
					break;
				case FEED_SERVICE:
					feedService( parameters );
					break;
			}
		}
		
		public function top100Service(params:ParamsBase=null):void
		{
			handleServiceLoading(TOP_100_URL,determineParams(params,TOP_100_SERVICE));
		}
		
		public function newReleasesService(params:ParamsBase=null):void
		{
			handleServiceLoading(NEW_RELEASES_URL,determineParams(params,NEW_RELEASES_SERVICE));
		}
		
		public function newInstantService(params:ParamsBase=null):void
		{
			handleServiceLoading(NEW_INSTANT_URL,determineParams(params,NEW_INSTANT_SERVICE));
		}
		
		public function feedService(params:ParamsBase=null):void
		{
			handleServiceLoading(FEEDS_URL,determineParams(params,FEED_SERVICE));
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function handleServiceLoading(methodString:String, params:ParamsBase = null):void
		{
			super.handleServiceLoading(methodString, params);
			
			if(checkForConsumerKey()==false)
				return;
			
			var method:String = ServiceBase.GET_REQUEST_METHOD;
			var sendQuery:String = methodString;
			var typeQuery:String;
			
			if(!params)
				return;
			//protect again urls that are too long
			if(params.maxResults>75)
				params.maxResults = 75;
			
			switch(type)
			{
				case FEED_SERVICE:
					if(params.netflixId)
						sendQuery = params.netflixId;
					break;
				default:
					//do no adjustment
					break;
			}
			
			//check cached
			if(sendQuery == _lastFeed)
			{
				_getTitles( _lastFeedReturn );
				return;
			}
			
			_lastFeed = sendQuery;
			
			if(!_urlLoader)
			{
				_urlLoader = new URLLoader();
				_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				//functions
				_urlLoader.addEventListener(Event.COMPLETE,_service_CompleteHandler);
				_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,faultHandler);
				_urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			}
			
			_urlLoader.load(new URLRequest(sendQuery));
		}
		
		/**
		 * @private
		 * Complete Handler. 
		 * @param event
		 * 
		 */		
		private function _service_CompleteHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var queryXML:XML = XML(loader.data);
			_clearLoader();
			
			if(queryXML=="Timestamp Is Invalid")
				getServerTimeOffset();
			else if(queryXML.Error == undefined)
				formatAndDispatch(queryXML);
			else
				dispatchFault(new ServiceFault(NetflixFaultEvent.API_RESPONSE, queryXML.Error, queryXML.Error.Message));
		}
		
		override protected function formatAndDispatch(returnedXML:XML):void
		{
			_getTitles( NetflixXMLUtilV2.handleRssResult(returnedXML) );
		}
		
		private function _getTitles(list:Array):void
		{
			if(!_ratingService)
			{
				_ratingService = new RatingService();
				_ratingService.addEventListener(NetflixResultEvent.PREDICTED_RATING_RESULT, _onRatingService_ResultHandler);
				_ratingService.addEventListener(NetflixFaultEvent.FAULT, _onRatingService_FaultHandler);
			}
			
			_lastFeedReturn = list;
			_numberOfResults = _lastFeedReturn.length;
			_currentIndex = request.startIndex;
			_resultsPerPage = request.maxResults;
			
			_ratingService.getPredictedRating(_lastFeedReturn.slice(request.startIndex,request.startIndex+request.maxResults), request.expansions);
		}
		
		private function _onRatingService_ResultHandler(event:NetflixResultEvent):void
		{
			lastNetflixResult = event.result;
			dispatchResult(event.result,type,event.rawXML);
		}
		
		private function _onRatingService_FaultHandler(event:NetflixFaultEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		private function _clearLoader():void
		{
			if(_urlLoader)
			{
				try{
					_urlLoader.close();
				} catch(e:Error){
					//no stream open
				}
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,faultHandler);
				_urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_urlLoader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				_urlLoader.removeEventListener(Event.COMPLETE,_service_CompleteHandler);
				_urlLoader = null;
			}
		}
		
		//---------------------------------------------------------------------
		//
		// No Params Quick Functions
		//
		//---------------------------------------------------------------------
		public function getTop100(startIndex:int=0, maxResults:int=25, expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			top100Service(params);
		}
		
		public function getNewReleases(startIndex:int=0, maxResults:int=25, expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			newReleasesService(params);
		}
		
		public function getNewInstant(startIndex:int=0, maxResults:int=25, expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			newInstantService(params);
		}
		
		public function getFeedByName(feed:String, startIndex:int=0, maxResults:int=25, expansions:String = null):void
		{
			var params:ParamsBase = new ParamsBase();
			params.netflixId = feed;
			params.startIndex = startIndex;
			params.maxResults = maxResults;
			params.expansions = expansions;
			feedService(params);
		}
		
		
	}
}
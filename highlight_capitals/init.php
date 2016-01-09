<?php

/**
 * @author Evoke. Salvoxia
 * @copyright 2012
 * @version 1.0
 */

$modInfo['highlight_capitals']['name'] = "Highlight Capitals";
$modInfo['highlight_capitals']['abstract'] = "highlights (Super)Capital kills/losses in killlisttables";
$modInfo['highlight_capitals']['about'] = "by <a href=\"http://gate.eveonline.com/Profile/Salvoxia\">Salvoxia</a>";

// register for adding a highlight class to every kill
event::register("killlist_table_kill", "highlight_capitals::modify");



// register for home page assembling for CSS injection and template replacement
event::register("home_assembling", "highlight_capitals::handler");

// register for corp detail assembling for CSS injection and template replacement
event::register("corpDetail_assembling", "highlight_capitals::handler");

// register for alliance detail assembling for CSS injection and template replacement
event::register("allianceDetail_assembling", "highlight_capitals::handler");

// register for pilot detail assembling for CSS injection and template replacement
event::register("pilotDetail_assembling", "highlight_capitals::handler");

// register for contract detail assembling for CSS injection and template replacement
event::register("contractDetail_assembling", "highlight_capitals::handler");

// register for system detail assembling for CSS injection and template replacement
event::register("systemdetail_assembling", "highlight_capitals::handler");


class highlight_capitals {

        private static $capitals = array(19, 27, 20, 29, 34, 39);
        private static $superCapitals = array(26, 28);

        /**
         * adds the highlight parameter with the highlight class name to each kill
         * @param array $kill
         * @return array
         */
		public static function modify(&$kill)
		{
			   $shipClassId = self::getShipClassIDByName($kill["victimshipclass"]);
			   if(in_array($shipClassId, self::$capitals))
			   {
				   $kill["highlight"] = "kl-capital-highlight";
			   }
			   elseif(in_array($shipClassId, self::$superCapitals))
			   {
				   $kill["highlight"] = "kl-supercapital-highlight";
			   }
			   else {
				   $kill["highlight"] = "";
			   }

			   return $kill;
		}


        public static function handler(&$home)
        {
               // $home->addBehind(config::get('mostexp_position'), "mostexpensive::display");
                $home->addBehind("start", "highlight_capitals::header");
                $home->addBefore("killList", "highlight_capitals::customKillList");
        }

        /**
         * inject custom KillListClass
         */
        public static function customKillList()
        {
            include(getcwd() . "/mods/highlight_capitals/includes/class.killlisttable.php");
        }


        /**
         *
         * @param pageAssembly $page
         */
        public static function header($page)
        {
           $modDir = config::get("cfg_kbhost") . '/mods/' . basename(dirname(__FILE__)) . '/';
           $page->page->addHeader("\t<link rel=\"stylesheet\" type=\"text/css\" href=\"{$modDir}css/highlightCapitals.css\" />");
        }


        public static function getShipClassIDByName($shipClassName)
        {
            $query = "SELECT scl_id FROM kb3_ship_classes WHERE scl_class = '{$shipClassName}'";
            $qry   = DBFactory::getDBQuery();
            $qry->execute($query);
            $shipClassId = $qry->getRow();
            return $shipClassId["scl_id"];
        }
}
?>
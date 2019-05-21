class UIScreenlistenerMCM_XCOM2RPGOverhaul extends UIScreenListener config(notarealconfig);

`include(XCOM2RPGOverhaul\Src\ModConfigMenuAPI\MCM_API_Includes.uci)
`include(XCOM2RPGOverhaul\Src\ModConfigMenuAPI\MCM_API_CfgHelpers.uci)

var config int CONFIG_VERSION;
var config bool cbPatchBullpups;
var config bool cbPatchShotguns;
var config bool cbPatchCannons;
var config bool cbPatchPistols;
var config bool cbPatchAutoPistols;
var config bool cbPatchDefaultWeaponUpgradeSlots;
var config bool cbPatchHeavyWeaponMobility;
var config bool cbPatchFullAutoFire;

event OnInit(UIScreen Screen)
{
	if (MCM_API(Screen) != none)
	{
		`MCM_API_Register(Screen, ClientModCallback);
	}
}

simulated function ClientModCallback(MCM_API_Instance ConfigAPI, int GameMode)
{
    local MCM_API_SettingsPage Page;
    local MCM_API_SettingsGroup Group;
    
    LoadSavedSettings();
    
    Page = ConfigAPI.NewSettingsPage(strModTitle);
    Page.SetPageTitle(strPageTitle);
    Page.SetSaveHandler(SaveButtonClicked);
    
    Group = Page.AddGroup('Group1', strSettingsTitle);
    
	Group.AddCheckbox('cbPatchBullpups', strButton1, strButton1TT, cbPatchBullpups, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchShotguns', strButton2, strButton2TT, cbPatchBullpups, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchCannons', strButton3, strButton3TT, cbPatchCannons, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchAutoPistols', strButton4, strButton4TT, cbAutoPatchPistols, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchDefaultWeaponUpgradeSlots', strButton5, strButton5TT, cbPatchDefaultWeaponUpgradeSlots, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchHeavyWeaponMobility', strButton6, strButton6TT, cbPatchHeavyWeaponMobility, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchFullAutoFire', strButton7, strButton7TT, cbPatchFullAutoFire, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchPistols', strButton8, strButton8TT, cbPatchPistols, CheckboxSaveHandler);	
    
    Page.ShowSettings();
}


`MCM_CH_VersionChecker(class'XCOM2RPGOverhaul_Defaults'.default.VERSION,CONFIG_VERSION)

simulated function LoadSavedSettings()
{
    cbPatchBullpups = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchBullpups, cbPatchBullpups);
	cbPatchShotguns = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchShotguns, cbPatchShotguns);
	cbPatchCannons = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchCannons, cbPatchCannons);
	cbPatchPistols = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchPistols, cbPatchPistols);
	cbPatchAutoPistols = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchAutoPistols, cbPatchAutoPistols);
	cbPatchDefaultWeaponUpgradeSlots = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchDefaultWeaponUpgradeSlots, cbPatchDefaultWeaponUpgradeSlots);
	cbPatchHeavyWeaponMobility = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchHeavyWeaponMobility , cbPatchHeavyWeaponMobility);
	cbPatchFullAutoFire  = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchFullAutoFire, cbPatchFullAutoFire);
}


simulated function SaveButtonClicked(MCM_API_SettingsPage Page)
{
    self.CONFIG_VERSION = `MCM_CH_GetCompositeVersion();
    self.SaveConfig();
}

defaultproperties
{
    ScreenClass = none;
}
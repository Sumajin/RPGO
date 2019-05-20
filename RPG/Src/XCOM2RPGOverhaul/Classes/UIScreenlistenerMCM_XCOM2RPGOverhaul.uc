class UIScreenlistenerMCM_XCOM2RPGOverhaul extends UIScreenListener config(XCOM2RPGOverhaul);

`include(RPG/Src/ModConfigMenuAPI/MCM_API_Includes.uci)
`include(RPG/Src/ModConfigMenuAPI/MCM_API_CfgHelpers.uci)

var config bool CHECKBOX_VALUE;
var config int CONFIG_VERSION;



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
    
	Group.AddCheckbox('cbPatchBullpups', strButton1, strButton1TT, CHECKBOX_VALUE, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchShotguns', strButton2, strButton2TT, CHECKBOX_VALUE, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchCannons', strButton3, strButton3TT, CHECKBOX_VALUE, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchPistols', strButton4, strButton4TT, CHECKBOX_VALUE, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchDefaultWeaponUpgradeSlots', strButton5, strButton5TT, CHECKBOX_VALUE, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchHeavyWeaponMobility', strButton6, strButton6TT, CHECKBOX_VALUE, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchFullAutoFire', strButton7, strButton7TT, CHECKBOX_VALUE, CheckboxSaveHandler);
    Group.AddCheckbox('cbPatchAutoPistols', strButton8, strButton8TT, CHECKBOX_VALUE, CheckboxSaveHandler);	
    
    Page.ShowSettings();
}

`MCM_CH_VersionChecker(class'XCOM2RPGOverhaul_Defaults'.default.VERSION,CONFIG_VERSION)

simulated function LoadSavedSettings()
{
    bPatchBullpups = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.PatchBullpups, PatchBullpups);
	bPatchShotguns = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.PatchShotguns, PatchShotguns);
	bPatchCannons = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchCannons, bPatchCannons);
	bPatchPistols = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchPistols, bPatchPistols);
	bPatchAutoPistols = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchAutoPistols, bPatchAutoPistols);
	bPatchDefaultWeaponUpgradeSlots = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchDefaultWeaponUpgradeSlots, bPatchDefaultWeaponUpgradeSlots);
	bPatchHeavyWeaponMobility = `MCM_CH_GetValue(class'XCOM2RPGOverhaul_Defaults'.default.bPatchHeavyWeaponMobility , bPatchHeavyWeaponMobility);
	bPatchFullAutoFire  = `MCM_CH_GetValue(class'XCOM2RPGOverhau__Defaults'.default.bPatchFullAutoFire, bPatchFullAutoFire);
}

`MCM_API_BasicCheckboxSaveHandler(CheckboxSaveHandler, CHECKBOX_VALUE)

simulated function SaveButtonClicked(MCM_API_SettingsPage Page)
{
    self.CONFIG_VERSION = `MCM_CH_GetCompositeVersion();
    self.SaveConfig();
}


defaultproperties
{
    ScreenClass = none;
}
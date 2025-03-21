Mode: [Device.Name]
IP: [Device.FirstAddress]
[ros_command("
{
:local identitylabel \"Identity: \";
:local identity [/system identity get name]
:put \"$identitylabel $identity\";
}
}
")][if(device_property("Ros"),"---------------Details---------------","")]
[ros_command("
{
:local boardnamelabel \"Boardname: \";
:local boardname [/system resource get board-name]
:put \"$boardnamelabel $boardname\";
}
}
")][ros_command("
{
:local modellabel \"Model: \";
:local model [/system routerboard get model]
:put \"$modellabel $model\";
}
}
")][ros_command("
{
:local maclabel \"MAC: \";
:local mac [/interface ethernet get 0 mac-address]
:put \"$maclabel $mac\";
}
}
")][ros_command("
{
:local seriallabel \"Serial: \";
:local serial [/system routerboard get serial-number]
:put \"$seriallabel $serial\";
}
}
")][if(device_property("Ros"),"---------------Health---------------","")]
[ros_command("
{
:if ([:len [/system health get voltage]]>0) do={
:local voltagelabel \"Voltage: \";
:local voltage ([/system health get voltage]/10)
:put \"$voltagelabel $voltage\";
}
}
}
")][ros_command("
{
:if ([:len [/interface ethernet find]]=1) do={
:local ethernetspeedlabel \"Ethernet Speed: \";
:local ethernetspeed [/interface ethernet get 0 speed]
:put \"$ethernetspeedlabel $ethernetspeed\";
}
}
}
")][if(device_property("Ros"),"---------------Wireless---------------","")]
[ros_command("
{
:if ([:len [/system package find where !disabled and name=wireless]]>0) do={
:local frequencylabel \"Frequency: \";
:if ([:len [/interface find where name=wlan1]]>0) do={
:local apfrequency [/interface wireless get wlan1 frequency]
:put \"$frequencylabel $apfrequency\";
}
}
}
")][ros_command("
{
:if ([:len [/system package find where !disabled and name=wireless]]>0) do={
:local scanlistlabel \"Scan-List: \";
:put \"$scanlistlabel\"
:if ([:len [/interface find where name=wlan1]]>0) do={
:local scanlist [/interface wireless get wlan1 scan-list]
:put \"$scanlist\";
}
}
}
")][ros_command("
{
:if ([:len [/system package find where !disabled and name=wireless]]>0) do={
:local ssidlabel \"SSIDs: \";
:if ([:len [/interface find where name=wlan1]]>0) do={
:foreach i in=[/interface wireless find] do={
:local ssids [/interface wireless get $i ssid]
:put \"$ssidlabel $ssids\";
}
}
}
}
")][if(device_property("Ros"),"---------------Checks---------------","")]
[ros_command("
{
:if ([:len [/system package find where !disabled and name=wireless]]>0) do={
:if ([:len [/interface find where name=wlan1]]>0) do={
:local apmode [/interface wireless get wlan1 mode]
:if ($apmode=\"ap-bridge\" || $apmode=\"bridge\") do={
:foreach i in=[/interface wireless find] do={
:local defauthenticate [/interface wireless get $i default-authentication]
:local wlanname [/interface wireless get $i name]
:local defauthenticatelabel \"Interface $wlanname Default Authenticate: \";
:put \"$defauthenticatelabel $defauthenticate\";
}
}
}
}
}
}
")][ros_command("
{
:local romonlabel \"Romon: \";
:local romon [/tool romon get enabled];
:put \"$romonlabel $romon\";
}
")][ros_command("
{
:local userslabel \"Users: \";
:put $userslabel;
:foreach i in=[/user find] do={
:local users [/user get number=$i name]
:put \"$users\";
}
}
")][if(device_property("Ros"),"---------------Down Services---------------","")]
[Device.ServicesDown]

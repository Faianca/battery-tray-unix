module cteam.battery;

import std.stdio;
import std.path;
import std.file;
import std.string;
import std.conv;
import std.math;

int main(string[] args)
{
    Battery bat = new Battery();
    writeln(bat.getState());
    writeln(bat.getPercentage());
    return 0;
}

/***
** Battery
**/
class Battery
{
    /**
    * The Power States
    */
    enum info
    {
        Status   = "status",
        Power    = "OnBattery",
        Type     = "type",
        Model    = "Charging",
        Serial   = "Charged",
        Now      = "energy_now",
        Full     = "energy_full",
    }

    private string batteryPath;

    this()
    {
        batteryPath = "/sys/class/power_supply/BAT0";
    }

    string getState()
    {
        return read(info.Status);
    }

    string getRemainingTime()
    {
        float remain = 111;
        float dischargeRate = 111;

        float remainingTime = remain / dischargeRate;
        int hours = to!int(remainingTime);
        int minutes = to!int(((remainingTime-hours)*60));

        char szBuffer[256];
        //sprintf(szBuffer, "%d:%02d", hours, minutes);

        return "coming soon";
    }

    string getPercentage()
    {
        float full = to!float(read(info.Full));
        float now = to!float(read(info.Now));

        int value = to!int(round(now) / round(full) * 100);
        return to!string(value) ~ "%";
    }

    string getType()
    {
        return read(info.Type);
    }

    string getSerialNumber()
    {
        return read(info.Serial);
    }

    string getModelNumber()
    {
        return read(info.Model);
    }

    private auto read(string type)
    {
        string status = chomp(readText(buildPath(batteryPath, type)));
        return status;
    }

}

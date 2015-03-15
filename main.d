import cteam.battery : Battery;
import std.stdio;

int main(string[] args)
{
    Battery bat = new Battery();
    writeln(bat.getState());
    writeln(bat.getPercentage());
    return 0;
}

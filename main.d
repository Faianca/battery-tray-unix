import battery;
import std.stdio;
import gtk.MainWindow;
import gtk.Label;
import gtk.Main;
import gtk.Menu;
import gtk.MenuItem;
import gtk.StatusIcon;
import gobject.Signals;
import std.functional;

void main(string[] args)
{
	Main.init(args);
	Test t = new Test();
	Main.run();
}

class Test
{
	public this()
	{
		Battery bat = new Battery();
		StatusIcon st = new StatusIcon();
		
		Menu s = new Menu();
		s.setTooltipText("sdas");
		st.setFromFile("/home/faianca/dlang/battery/battery-connect.png");
		st.setTooltipText("sadsad");
		st.setTooltipText(bat.getState() ~ " " ~ bat.getPercentage());
		
		MenuItem ss = new MenuItem("sup");
		ss.show();
		s.append(ss);
		s.show();
		
		st.addOnActivate(&showMenu(s));
	}

	void showMenu(Menu s)
	{

	}
}



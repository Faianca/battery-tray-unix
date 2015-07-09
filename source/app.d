private import std.c.stdlib: getenv;

private import gtk.Main;
private import gtk.Window;
private import gtk.MainWindow;
private import gtk.StatusIcon;
private import gtk.Widget;
private import gtk.Button;
private import gtk.Button;
private import gtk.Entry;
private import gtk.SpinButton;
private import gtk.Menu;
private import gtk.MenuItem;
private import gtk.AboutDialog;
private import gtk.Dialog;
private import gtk.Label;

private import gdk.Keymap;
private import gdk.Event;
private import gdk.Rectangle;
private import gobject.Value;

//private import glade.Glade;

private import glib.Util;
private import glib.FileUtils;

import battery;
import std.stdio;

void main(string[] args)
{
   Main.init(args);
   Tray win = new Tray();
   Main.run();
}


class MenuC : Menu
{
    void changeImage()
    {

    }

    void updateTooltip()
    {

    }

    void addSubmenu(MenuItem submenu)
    {
        append(submenu);
    }
}

class Tray
{
	 Menu s;

    this()
    {
        //super("hello world");
        //setDefaultSize(200, 100);
        //add(new Label("Faianca Power :x"));
        //showAll();

        StatusIcon st = new StatusIcon();
	    Battery bat = new Battery();
	    writeln(bat.getState() ~ " " ~ bat.getPercentage());

	    s = new Menu();
	    s.setTooltipText("sdas");
	    st.setFromFile("/home/jmeireles/dlang/battery-tray-unix/styles/battery-connect.png");
	    st.setTooltipText("Ssdada");
	    st.addOnActivate(&onStatusIconClicked);
	     st.addOnPopupMenu(&onStatusIconShowPopupMenu);
	   
	    MenuItem ss = new MenuItem("sup");
	    ss.show();
	    s.append(ss);
	    s.show();
    }

    private void onStatusIconClicked(StatusIcon widget) 
    {
		writeln("clicked like a boss.");
	}

	/**
	 * Callback called when the status icon has to show a popup menu.
	 */
	private void onStatusIconShowPopupMenu (uint button, uint time, StatusIcon widget)
	{
		this.s.popup(null, null, null, cast(void *) widget, button, time);
	}

}

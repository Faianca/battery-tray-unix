private import gtk.Main;
private import gtk.Window;
private import gtk.MainWindow;
private import gtk.StatusIcon;
private import gtk.Widget;
private import gtk.Button;
private import gtk.Entry;
private import gtk.SpinButton;
private import gtk.Menu;
private import gtk.MenuItem;
private import gtk.AboutDialog;
private import gtk.Dialog;
private import gtk.Label;
private import gtk.MessageDialog;
private import std.c.stdlib: getenv;
private import gdk.Keymap;
private import gdk.Event;
private import gdk.Rectangle;
private import gobject.Value;
private import glib.Util;
private import glib.FileUtils;

import battery;
import std.stdio;

class MainMenu : Menu
{
  void refreshToolTip(Battery bat)
  {
      this.setTooltipText(bat.getState() ~ " " ~ bat.getPercentage());
  }

    void addSubmenu(MenuItem submenu)
    {
        append(submenu);
    }
}

class Tray
{
  private MainMenu mainMenu;
  StatusIcon st;

    this()
    {
        st = new StatusIcon();
      Battery bat = new Battery();
      writeln(bat.getState() ~ " " ~ bat.getPercentage());

      mainMenu = new MainMenu();
   
      st.setFromFile("/home/jmeireles/dlang/battery-tray-unix/styles/battery-connect.png");
      st.setTooltipText(bat.getState() ~ " " ~ bat.getPercentage());

      st.addOnActivate(&onStatusIconClicked);
      st.addOnPopupMenu(&onStatusIconShowPopupMenu);
      
      MenuItem aboutMenu = new MenuItem("About");
      MenuItem quitMenu = new MenuItem("Quit");

      quitMenu.addOnActivate(&quit);
      aboutMenu.addOnActivate(&about);

      mainMenu.addSubmenu(aboutMenu);
      mainMenu.addSubmenu(quitMenu);
      mainMenu.showAll();
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
    this.mainMenu.popup(null, null, null, cast(void *) widget, button, time);
  }

  /**
  * About Dialog
  */
  private void about(MenuItem widget)
  {
      MessageDialog aboutDialog = new MessageDialog(null, GtkDialogFlags.MODAL, MessageType.INFO, ButtonsType.OK, "By Cteam-Lab 1.0!");
        aboutDialog.setTitle("About");
        aboutDialog.setPosition(GtkWindowPosition.CENTER);
        aboutDialog.setMarkup("Battery Tray 1.0 \nBy Jorge Meireles - Cteam");
        aboutDialog.run();
        aboutDialog.destroy();
  }
  
  private void quit(MenuItem widget)
  {
    Main.quit();
  }

}
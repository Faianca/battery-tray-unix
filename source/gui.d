module gui;

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
private import glib.Timeout;
import gtk.TreeView;
import gtk.TreeViewColumn;
import gtk.CellRendererText;
import gtk.ListStore;
import gtk.ComboBox;
private import gtk.TreeIter;
private import gtkc.gobjecttypes;
import themeManager;
import battery;
import std.stdio;
import glib.RandG;


class MainMenu : Menu
{
    void addSubmenu(MenuItem submenu)
    {
        append(submenu);
    }
}

enum
{
    COL_NAME = 0,
    COL_AGE,
    NUM_COLS
};

class ThemeSwitcher : Window
{ 
    ComboBox view;
    TreeViewColumn   col;
    CellRendererText renderer;
    ListStore       customlist;

    this()
    {
        super("Theme Switcher");
        this.setPosition(GtkWindowPosition.CENTER);
        this.setBorderWidth(10);
        this.setDefaultSize(300,20);

        customlist = new ListStore([GType.STRING, GType.STRING]);
        TreeIter iter = customlist.createIter();
        customlist.setValue(iter, 0, "dsasadas");
        customlist.setValue(iter, 1, "testee");
        
        customlist.setValue(iter, 0, "olll");
        customlist.setValue(iter, 1, "lololol");

        view = new ComboBox();
        renderer = new CellRendererText();
        view.packStart(renderer, true);
        view.addAttribute(renderer, "text", 0);
        view.setModel(customlist);
        view.setActive(1);
        view.show();
        add(view);
    }
}

class Tray
{
    private MainMenu mainMenu;
    private ThemeSwitcher themeSwitcher;
    private Timeout timeout;
    private StatusIcon st;
    private Battery bat;
    private string defaultStyle = "green";
    private ThemeManager themeManager;
    private int lastImageLevel = 0;

    this()
    {
      themeSwitcher = new ThemeSwitcher();
      themeSwitcher.show();
      themeManager = new ThemeManager();
      bat = new Battery();
      mainMenu = new MainMenu();
      st = new StatusIcon();
      st.addOnPopupMenu(&onStatusIconShowPopupMenu);

      MenuItem themeSwitcherMenu = new MenuItem("Theme Switcher");
      MenuItem aboutMenu = new MenuItem("About");
      MenuItem quitMenu = new MenuItem("Quit");

      quitMenu.addOnActivate(&quit);
      aboutMenu.addOnActivate(&about);
      themeSwitcherMenu.addOnActivate(&switchTheme);

      mainMenu.addSubmenu(themeSwitcherMenu);
      mainMenu.addSubmenu(aboutMenu);
      mainMenu.addSubmenu(quitMenu);
      mainMenu.showAll();

      timeout = new Timeout(1000, &refresh);
    }

    bool refresh()
    {
        int imageLevel = bat.getBatteryLevel() / 30;

        if (imageLevel != this.lastImageLevel) {
            string image = (bat.isCharging()) ? themeManager.getConnectedImage() : themeManager.getImage(imageLevel);
            st.setFromFile(image);
            this.lastImageLevel = imageLevel;
        }

        st.setTooltipText(bat.getState() ~ " " ~ bat.getPercentage());

        return true;
    }

  private:
    void switchTheme(MenuItem widget)
    {

    }

    /**
     * Callback called when the status icon has to show a popup menu.
     */
    void onStatusIconShowPopupMenu (uint button, uint time, StatusIcon widget)
    {
      this.mainMenu.popup(null, null, null, cast(void *) widget, button, time);
    }

    /**
    * About Dialog
    */
    void about(MenuItem widget)
    {
        MessageDialog aboutDialog = new MessageDialog(null, GtkDialogFlags.MODAL, MessageType.INFO, ButtonsType.OK, "By Cteam-Lab 1.0!");
          aboutDialog.setTitle("About");
          aboutDialog.setPosition(GtkWindowPosition.CENTER);
          aboutDialog.setMarkup("Battery Tray 1.0 \nBy Jorge Meireles - Cteam");
          aboutDialog.run();
          aboutDialog.destroy();
    }
    
    /**
    * Quit the GTK Main loop
    */
    void quit(MenuItem widget)
    {
      Main.quit();
    }

}
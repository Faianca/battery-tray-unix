import battery;
import std.stdio;
import gtk.MainWindow;
import gtk.Label;
import gtk.Main;
import gtk.Menu;
import gtk.MenuItem;
import gtk.StatusIcon;

void main(string[] args)
{
   Main.init(args);

   Battery bat = new Battery();
   //MainWindow win = new Tray();
   StatusIcon st = new StatusIcon();

   Menu s = new Menu();
   s.setTooltipText("sdas");
   st.setFromFile("battery-connect.png");
   //st.setTooltipText("sadsad");
   st.setTooltipText(bat.getState() ~ " " ~ bat.getPercentage());

   MenuItem ss = new MenuItem("sup");
   ss.show();
   s.append(ss);
   s.show();
   Main.run();
}

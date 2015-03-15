
import gtk.MainWindow;
import gtk.Label;
import gtk.Main;
import gtk.Menu;
import gtk.MenuItem;
import gtk.StatusIcon;

void main(string[] args)
{
   Main.init(args);
   //MainWindow win = new Tray();
   StatusIcon st = new StatusIcon();

   Menu s = new Menu();
   s.setTooltipText("sdas");
   st.setFromFile("battery-connect.png");
   st.setTooltipText("Ssdada");

   MenuItem ss = new MenuItem("sup");
   ss.show();
   s.append(ss);
   s.show();
   Main.run();
}

class Tray : MainWindow
{
    this()
    {
        super("hello world");
        setDefaultSize(200, 100);
        add(new Label("Faianca Power :x"));
        showAll();
    }
}

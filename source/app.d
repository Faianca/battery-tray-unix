
private import gtk.Main;
private import gui;

void main(string[] args)
{
   Main.init(args);
   Tray win = new Tray();
   Main.run();
}


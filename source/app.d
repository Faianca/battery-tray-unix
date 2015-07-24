module app;
private import gtk.Main;
private import gui;

void main(string[] args)
{
   Main.init(args);
   Tray win = new Tray();
   win.refresh();
   Main.run();
}


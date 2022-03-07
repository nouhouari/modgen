import { Input } from '@angular/core';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Router } from '@angular/router';
import { DynamicMenu, initialNavigation } from './menu';


@Component({
  selector: 'menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.scss']
})
export class MenuComponent implements OnInit {

  @Output() toggleSideNav: EventEmitter<boolean> = new EventEmitter<boolean>();
  @Input() items: DynamicMenu[];

  menuList:DynamicMenu[]=initialNavigation;

  constructor(private router: Router) { }
  ngOnInit(): void {
   
  }

  closeNav() {
    this.toggleSideNav.emit(true);
  }

  menuClicked(){
    this.closeNav()
  }

  redirect(menuItem: DynamicMenu) {
    const route = menuItem.url;
 

    if (!route) {
      return;
    }

    if (route) {
      this.router.navigate([route]);
    } 

    this.closeNav();
  }

}





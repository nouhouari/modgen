import { Component, Input, OnInit } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {

  @Input() showBreadcrumb: boolean = true;
  @Input() showHome: boolean = true;
  isHelpVisible: boolean = true;
  readonly languages = [
    { value: 'En', label: 'English', img: 'assets/gb.svg' },
    { value: 'It', label: 'Italiano', img: 'assets/it.svg' },
    { value: 'Ru', label: 'Русский', img: 'assets/ru.svg' }
  ];

  public language = this.languages[0];

  constructor() { }

  ngOnInit(): void {
  }

  selectLanguage(value: string) {
    this.language = this.languages.find(lang => lang.value === value);
  }

}

import { Component, OnInit, AfterViewInit, ViewChild, ElementRef } from '@angular/core';
import { FormGroup, FormControl, Validators, ReactiveFormsModule, FormsModule } from '@angular/forms';
import { RouterOutlet } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Task } from './model/task';
import { WebsocketService } from './service/websocket.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, ReactiveFormsModule, FormsModule, CommonModule],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit, AfterViewInit {
  notify:number = 0;

  title = 'real-dashboard-client';
  tasks: Task[] = [];

  form: FormGroup = new FormGroup({
    name: new FormControl<string>('', Validators.required),
    days: new FormControl<number>(0, Validators.required)
  });

  @ViewChild('scrollContainer') private scrollContainer!: ElementRef;

  constructor(private webSocketService: WebsocketService) {}

  ngOnInit(): void {
    this.webSocketService.getAll().subscribe((tasks: Task[]) => {
      this.tasks = tasks;
      // this.scrollToBottom();
    });

    this.webSocketService.listen(task => {
      this.notify = this.notify + 1;
      this.tasks.push(task);
      // this.scrollToBottom();
    });
  }

  ngAfterViewInit() {
    this.scrollToBottom();
  }

  click(): void {
    const task: Task = { name: this.form.value.name, days:this.form.value.days };
    this.webSocketService.send(task);
    this.form.reset({ name: '', days: 0 });
  }

  private scrollToBottom(): void {
    try {
      this.scrollContainer.nativeElement.scrollTop = this.scrollContainer.nativeElement.scrollHeight;
    } catch(err) {}
  }
}

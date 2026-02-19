import { Component, OnInit } from '@angular/core';
import { ChatMessage, WebsocketExampleService } from '../../service/websocket-example.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-chat-example',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './chat-example.component.html',
  styleUrl: './chat-example.component.scss'
})
export class ChatExampleComponent implements OnInit {
  username: string = '';
  messageContent: string = '';
  receiver: string = '';
  connected = false;

  publicMessages: ChatMessage[] = [];
  privateMessages: ChatMessage[] = [];

  constructor(private chatService: WebsocketExampleService) {}

  ngOnInit(): void {
    this.chatService.publicMessages$.subscribe(msgs => this.publicMessages = msgs);
    this.chatService.privateMessages$.subscribe(msgs => this.privateMessages = msgs);
  }

  connect() {
    if (!this.username) return;

    // Load old messages
    this.chatService.loadOldMessages(this.username);

    // Connect WebSocket
    this.chatService.connect(this.username);
    this.connected = true;
  }

  sendPublic() {
    if (!this.messageContent) return;
    this.chatService.sendPublicMessage({
      sender: this.username,
      content: this.messageContent
    });
    this.messageContent = '';
  }

  sendPrivate() {
    if (!this.messageContent || !this.receiver) return;
    this.chatService.sendPrivateMessage({
      sender: this.username,
      receiver: this.receiver,
      content: this.messageContent
    });
    this.messageContent = '';
  }
}
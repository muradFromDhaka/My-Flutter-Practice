import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Client, IMessage, Message } from '@stomp/stompjs';
import { BehaviorSubject } from 'rxjs';
import SockJS from 'sockjs-client';

export interface ChatMessage {
  sender: string;
  receiver?: string;
  content: string;
}

@Injectable({
  providedIn: 'root'
})
export class WebsocketExampleService {
private stompClient!: Client;
  private serverUrl = 'http://192.168.20.40:8080/ws-chat'; // WebSocket endpoint
  private apiUrl = 'http://192.168.20.40:8080/api/chat'; // REST endpoint

  private publicMessagesSubject = new BehaviorSubject<ChatMessage[]>([]);
  public publicMessages$ = this.publicMessagesSubject.asObservable();

  private privateMessagesSubject = new BehaviorSubject<ChatMessage[]>([]);
  public privateMessages$ = this.privateMessagesSubject.asObservable();

  constructor(private http: HttpClient) {}

  // Load old messages
  loadOldMessages(username: string) {
    this.http.get<ChatMessage[]>(`${this.apiUrl}/public`)
      .subscribe(msgs => this.publicMessagesSubject.next(msgs));

    this.http.get<ChatMessage[]>(`${this.apiUrl}/private/${username}`)
      .subscribe(msgs => this.privateMessagesSubject.next(msgs));
  }

  // Connect WebSocket
  connect(username: string) {
    this.stompClient = new Client({
      brokerURL: undefined, // use SockJS
      webSocketFactory: () => new SockJS(this.serverUrl),
      reconnectDelay: 5000,
      debug: (str) => console.log(str),
      connectHeaders: { login: username }
    });

    this.stompClient.onConnect = () => {
      console.log('Connected to WebSocket');

      // Subscribe to public messages
      this.stompClient.subscribe('/topic/messages', (message: Message) => {
        const msg: ChatMessage = JSON.parse(message.body);
        this.publicMessagesSubject.next([...this.publicMessagesSubject.value, msg]);
      });

      // Subscribe to private messages
      this.stompClient.subscribe(`/user/${username}/queue/private`, (message: Message) => {
        const msg: ChatMessage = JSON.parse(message.body);
        this.privateMessagesSubject.next([...this.privateMessagesSubject.value, msg]);
      });
    };

    this.stompClient.activate();
  }

  sendPublicMessage(message: ChatMessage) {
    this.stompClient.publish({
      destination: '/app/send',
      body: JSON.stringify(message)
    });
  }

  sendPrivateMessage(message: ChatMessage) {
    this.stompClient.publish({
      destination: '/app/private',
      body: JSON.stringify(message)
    });
  }
}
import { Injectable, OnDestroy } from '@angular/core';
import { Client, IMessage, StompSubscription } from '@stomp/stompjs';
import SockJS from 'sockjs-client';
import { HttpClient } from '@angular/common/http';
import { Task } from '../model/task';

export type ListenerCallBack = (message: Task) => void;

@Injectable({
  providedIn: 'root'
})
export class WebsocketService implements OnDestroy {

  private client: Client;
  private subscriptions: StompSubscription[] = [];

  constructor(private http: HttpClient) {

    // Create STOMP client
    this.client = new Client({
      // Use SockJS
      webSocketFactory: () => new SockJS('http://192.168.20.40:8080/websocket'),
      reconnectDelay: 5000, // auto reconnect
      debug: () => {} // disable debug logs
    });

    // Error handling
    this.client.onStompError = (frame) => {
      console.error('STOMP error:', frame.headers['message'], frame.body);
    };

    this.client.onWebSocketError = (evt) => {
      console.error('WebSocket error:', evt);
    };

    // Connect
    this.client.activate();
  }

  getAll() {
    return this.http.get<Task[]>('http://192.168.20.40:8080/getAll');
  }

  send(task: Task) {
    if (this.client.connected) {
      this.client.publish({
        destination: '/app/add_new_task',
        body: JSON.stringify(task)
      });
    }
  }

  listen(callback: ListenerCallBack) {
    // Wait until connected
    const checkConnected = () => {
      if (this.client.connected) {
        const sub = this.client.subscribe('/topic/tasks/added_task', (message: IMessage) => {
          callback(JSON.parse(message.body));
        });
        this.subscriptions.push(sub);
      } else {
        setTimeout(checkConnected, 500);
      }
    };
    checkConnected();
  }

  ngOnDestroy() {
    this.subscriptions.forEach(sub => sub.unsubscribe());
    this.client.deactivate();
  }
}

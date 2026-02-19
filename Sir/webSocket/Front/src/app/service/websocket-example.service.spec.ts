import { TestBed } from '@angular/core/testing';

import { WebsocketExampleService } from './websocket-example.service';

describe('WebsocketExampleService', () => {
  let service: WebsocketExampleService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(WebsocketExampleService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

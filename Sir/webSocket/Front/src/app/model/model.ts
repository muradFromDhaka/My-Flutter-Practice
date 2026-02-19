export interface ChatGroup {
  id?: number;
  name: string;
  description: string;
  createdBy: string;
  createdAt: Date;
  isPrivate: boolean;
  members: string[];
  admins: string[];
}

export interface CreateGroupRequest {
  name: string;
  description: string;
  createdBy: string;
  isPrivate: boolean;
}

export interface AddMemberRequest {
  username: string;
  addedBy: string;
}

export interface GroupEvent {
  type: string;
  group: ChatGroup;
  username?: string;
  timestamp: Date;
}
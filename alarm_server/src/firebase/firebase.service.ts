import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import serviceAccount from './topic-on-5dbc0-firebase-adminsdk-rgd3q-2b97a90fda.json';

@Injectable()
export class FirebaseService {
  private messaging: admin.messaging.Messaging;

  constructor() {
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
    });

    this.messaging = admin.messaging();
  }

  async sendNotification(token: string, title: string, body: string) {
    const message = {
      notification: {
        title: title,
        body: body,
      },
      data: {
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
        message: body,
      },
      token: token,
    };

    try {
      const response = await this.messaging.send(message);
      console.log('Successfully sent message:', response);
    } catch (error) {
      console.log('Error sending message:', error);
    }
  }
}

import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello! this is TnV Laddha and I am a business applications analyst at AUC LLP. This is task submission for PearlThoughts Devops internship';
  }
}

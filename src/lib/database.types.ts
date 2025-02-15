export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      programs: {
        Row: {
          id: string
          title: string
          description: string
          duration: string
          price: number
          level: string
          created_at: string
        }
        Insert: {
          id?: string
          title: string
          description: string
          duration: string
          price: number
          level: string
          created_at?: string
        }
        Update: {
          id?: string
          title?: string
          description?: string
          duration?: string
          price?: number
          level?: string
          created_at?: string
        }
      }
      enrollments: {
        Row: {
          id: string
          user_id: string
          program_id: string
          status: string
          payment_status: string
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          program_id: string
          status?: string
          payment_status?: string
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          program_id?: string
          status?: string
          payment_status?: string
          created_at?: string
        }
      }
      contact_messages: {
        Row: {
          id: string
          name: string
          email: string
          subject: string
          message: string
          created_at: string
        }
        Insert: {
          id?: string
          name: string
          email: string
          subject: string
          message: string
          created_at?: string
        }
        Update: {
          id?: string
          name?: string
          email?: string
          subject?: string
          message?: string
          created_at?: string
        }
      }
      applications: {
        Row: {
          id: string
          full_name: string
          email: string
          phone: string
          program_id: string | null
          education_level: string
          work_experience: string | null
          status: string
          created_at: string
        }
        Insert: {
          id?: string
          full_name: string
          email: string
          phone: string
          program_id?: string | null
          education_level: string
          work_experience?: string | null
          status?: string
          created_at?: string
        }
        Update: {
          id?: string
          full_name?: string
          email?: string
          phone?: string
          program_id?: string | null
          education_level?: string
          work_experience?: string | null
          status?: string
          created_at?: string
        }
      }
      subscriptions: {
        Row: {
          id: string
          email: string
          created_at: string
        }
        Insert: {
          id?: string
          email: string
          created_at?: string
        }
        Update: {
          id?: string
          email?: string
          created_at?: string
        }
      }
    }
  }
}
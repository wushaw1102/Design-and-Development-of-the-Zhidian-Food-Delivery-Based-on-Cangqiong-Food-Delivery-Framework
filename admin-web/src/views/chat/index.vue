<template>
  <div class="chat-container">
    <div class="chat-box">
      <div class="chat-title">
        <svg class="robot-icon" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M12 2C13.1 2 14 2.9 14 4C14 5.1 13.1 6 12 6C10.9 6 10 5.1 10 4C10 2.9 10.9 2 12 2Z" fill="#FFC200"/>
          <path d="M21 8H19V7C19 5.34 17.66 4 16 4H14.82C14.4 2.84 13.3 2 12 2C10.7 2 9.6 2.84 9.18 4H8C6.34 4 5 5.34 5 7V8H3C2.45 8 2 8.45 2 9V18C2 19.1 2.9 20 4 20H20C21.1 20 22 19.1 22 18V9C22 8.45 21.55 8 21 8ZM16 16H8V14H16V16ZM16 12H8V10H16V12Z" fill="#FFC200"/>
        </svg>
        <span>智点大模型</span>
      </div>
      <div class="messages" ref="messageContainer">
        <div v-for="(msg, index) in messages" :key="index" :class="['message', msg.type]">
          <div class="message-content">{{ msg.content }}</div>
        </div>
      </div>
      <div class="input-area">
        <el-input
          v-model="currentMessage"
          placeholder="请输入您的问题..."
          :disabled="loading"
          @keyup.enter.native="sendMessage"
        >
          <el-button
            slot="append"
            :loading="loading"
            @click="sendMessage"
            style="color: #000000; background-color: #ffc200; border-color: #ffc200"
          >
            发送
          </el-button>
        </el-input>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Watch } from "vue-property-decorator";
import { askQuestion } from "@/api/chat";

interface Message {
  content: string;
  type: "user" | "assistant";
}

@Component({
  name: "Chat"
})
export default class extends Vue {
  private messages: Message[] = [];
  private currentMessage = "";
  private loading = false;

  @Watch("messages")
  onMessagesChange() {
    this.$nextTick(() => {
      const container = this.$refs.messageContainer as HTMLElement;
      if (container) {
        container.scrollTop = container.scrollHeight;
      }
    });
  }

  private async sendMessage() {
    if (!this.currentMessage.trim() || this.loading) {
      return;
    }

    const userMessage = this.currentMessage.trim();
    this.messages.push({
      content: userMessage,
      type: "user"
    });

    this.loading = true;
    this.currentMessage = "";

    try {
      const { data } = await askQuestion(userMessage);
      this.messages.push({
        content: data.data,
        type: "assistant"
      });
    } catch (error) {
      this.$message.error("发送消息失败，请重试");
    } finally {
      this.loading = false;
    }
  }
}
</script>

<style lang="scss" scoped>
.chat-container {
  padding: 20px;
  height: calc(100vh - 120px);
  display: flex;
  flex-direction: column;

  .chat-box {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    height: 100%;
    
    .chat-title {
      text-align: center;
      padding: 16px 0;
      font-size: 20px;
      font-weight: bold;
      color: #000000;
      border-bottom: 1px solid #eee;
      display: flex;
      align-items: center;
      justify-content: center;
      
      .robot-icon {
        margin-right: 8px;
      }
    }
    
    .messages {
      flex: 1;
      padding: 20px;
      overflow-y: auto;

      .message {
        margin-bottom: 16px;
        display: flex;
        flex-direction: column;

        &.user {
          align-items: flex-end;
          .message-content {
            background:rgb(242, 223, 17);
            color: #000000;
          }
        }

        &.assistant {
          align-items: flex-start;
          .message-content {
            background: #f4f4f5;
            color: #333;
          }
        }

        .message-content {
          max-width: 80%;
          padding: 12px 16px;
          border-radius: 8px;
          word-break: break-word;
          line-height: 1.5;
        }
      }
    }

    .input-area {
      padding: 20px;
      border-top: 1px solid #eee;

      .el-input {
        width: 100%;
      }

      :deep(.el-button) {
        color: #000000;
        background-color: #ffc200;
        border-color: #ffc200;
        transition: transform 0.3s ease;
        
        &:hover {
          background-color: #ffc200;
          border-color: #ffc200;
          transform: scale(1.05);
        }
        
        &:focus {
          background-color: #ffc200;
          border-color: #ffc200;
        }
      }
    }
  }
}
</style> 
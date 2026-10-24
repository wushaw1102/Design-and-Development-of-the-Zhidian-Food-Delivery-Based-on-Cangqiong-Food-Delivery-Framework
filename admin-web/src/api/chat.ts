import request from "@/utils/request";

export const askQuestion = (question: string) =>
  request({
    url: "/chat",
    method: "post",
    params: { question }
  }); 
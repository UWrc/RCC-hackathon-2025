import torch
from transformers import AutoModelForCausalLM, AutoTokenizer

local_model_path = "/gscratch/stf/hackathon/llm/mistral_7b"

tokenizer = AutoTokenizer.from_pretrained(local_model_path)
model = AutoModelForCausalLM.from_pretrained(
    local_model_path,
    device_map="auto",        # Automatically map model to available GPUs
    torch_dtype="auto"        # Use model's default precision
)

def generate(prompt, temperature=0.7, top_p=0.95, max_new_tokens=150):
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    with torch.no_grad():
        output = model.generate(
            **inputs,
            max_new_tokens=max_new_tokens,
            temperature=temperature,
            top_p=top_p,
            do_sample=True
        )
    return tokenizer.decode(output[0], skip_special_tokens=True)

prompt = "Write a short sci-fi story about a robot gaining emotions."

print("\n🔁 Different Temperatures:\n")
for t in [0.2, 0.7, 1.2, 2]:
    print(f"\n🔥 Temperature = {t}")
    print(generate(prompt, temperature=t))

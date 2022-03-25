SRC_DIR := ./src
INC_DIR := ./inc
OUT_DIR := ./out

CC := g++
ASM := nasm
CFLAGS := -std=gnu11 -o0 -w -I$(INC_DIR) -masm=intel

SRCS := $(wildcard $(SRC_DIR)/*.cpp)
INCS := $(filter-out $(INC_DIR)/main.h, $(SRCS:$(SRC_DIR)/%.cpp=$(INC_DIR)/%.h))
OBJS = $(SRCS:$(SRC_DIR)/%.cpp=$(OUT_DIR)/%.o)

APP := app.exe
APP_NO := app_no.exe

.PHONY : run run_no clean

run: $(APP)
	@./$(APP)


run_no: $(APP_NO)
	@./$(APP_NO)


$(APP) : CFLAGS += -DX87 -m80387
$(APP) : $(OBJS) $(INCS)
	@$(CC) $(CFLAGS) -o $@ $(OBJS)


$(APP_NO) : CFLAGS += -mno-80387
$(APP_NO) : $(OBJS) $(INCS)
	@$(CC) $(CFLAGS) -o -S $@ $(OBJS)


$(OUT_DIR):
	@mkdir -p $(OUT_DIR)


${OUT_DIR}/%.o : ${SRC_DIR}/%.cpp $(OUT_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@


$(INC_DIR)/%.h:
	@

clean:
	@$(RM) $(APP) $(APP_NO) ${OUT_DIR}/* ./*.o
	@rm -rf $(OUT_DIR)

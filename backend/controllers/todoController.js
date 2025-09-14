const Todo = require("../models/Todo");

const getTodos = async (req, res) => {
  try {
    const todos = await Todo.find({ userId: req.user.userId }).sort({ createdAt: -1 });
    res.status(200).json({
      success: true,
      count: todos.length,
      data: { todos }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Failed to fetch todos"
    });
  }
};

const createTodo = async (req, res) => {
  try {
    const { title } = req.body;
    const todo = await Todo.create({
      title,
      userId: req.user.userId
    });
    res.status(201).json({
      success: true,
      data: { todo }
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: "Failed to create todo"
    });
  }
};

const updateTodo = async (req, res) => {
  try {
    const { id } = req.params;
    const todo = await Todo.findOneAndUpdate(
      { _id: id, userId: req.user.userId },
      req.body,
      { new: true }
    );
    if (!todo) {
      return res.status(404).json({
        success: false,
        message: "Todo not found"
      });
    }
    res.status(200).json({
      success: true,
      data: { todo }
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      message: "Failed to update todo"
    });
  }
};

const deleteTodo = async (req, res) => {
  try {
    const { id } = req.params;
    const todo = await Todo.findOneAndDelete({ _id: id, userId: req.user.userId });
    if (!todo) {
      return res.status(404).json({
        success: false,
        message: "Todo not found"
      });
    }
    res.status(200).json({
      success: true,
      message: "Todo deleted successfully"
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Failed to delete todo"
    });
  }
};

module.exports = {
  getTodos,
  createTodo,
  updateTodo,
  deleteTodo
};

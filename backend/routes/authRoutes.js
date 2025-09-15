const express = require("express");
const {
  registerUser,
  loginUser,
  logoutUser,
  getUserProfile,
  updateUser,
  deleteUser,
} = require("../controllers/authController");
const { authenticateToken } = require("../middleware/authMiddleware");

const router = express.Router();

// Public routes
router.post("/register", registerUser);
router.post("/login", loginUser);
router.post("/logout", logoutUser);

// Protected routes
router.get("/profile", authenticateToken, getUserProfile);
router.put("/profile", authenticateToken, updateUser);
router.delete("/profile", authenticateToken, deleteUser);

module.exports = router;

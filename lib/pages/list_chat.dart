import 'package:flutter/material.dart';
import 'detail_chat.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({super.key});

  @override
  State<ListChatPage> createState() => _ListChatPageState();
}

class _ListChatPageState extends State<ListChatPage> {
  // Enhanced data dummy untuk daftar chat dengan unread count
  final List<Map<String, dynamic>> chats = [
    {
      "avatar": "assets/avatars/wibu1.png",
      "name": "Toko B Store",
      "message": "Terima kasih sudah berbelanja!",
      "time": "Kemarin",
      "unread": false,
      "unreadCount": 0,
      "isOnline": false,
    },
    {
      "avatar": "assets/avatars/wibu2.png",
      "name": "Wibu Store",
      "message": "Produk yang Anda cari tersedia kok",
      "time": "2 hari lalu",
      "unread": true,
      "unreadCount": 1,
      "isOnline": true,
    },
    {
      "avatar": "assets/avatars/wibu3.png",
      "name": "Dark Official",
      "message": "Baik, pesanan Anda sedang kami proses ya.",
      "time": "10:30",
      "unread": true,
      "unreadCount": 3,
      "isOnline": true,
    },
  ];

  String _selectedFilter = "Semua";

  List<Map<String, dynamic>> get filteredChats {
    if (_selectedFilter == "Belum Dibaca") {
      return chats.where((chat) => chat["unread"] == true).toList();
    }
    return chats;
  }

  void _markAsRead(int index) {
    setState(() {
      chats[index]["unread"] = false;
      chats[index]["unreadCount"] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unreadCount = chats.where((chat) => chat["unread"] == true).length;
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Pesan"),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Search coming soon!")),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced Filter Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildFilterButton("Semua", theme),
                const SizedBox(width: 12),
                _buildFilterButton("Belum Dibaca", theme),
              ],
            ),
          ),
          
          // Enhanced Chat List
          Expanded(
            child: filteredChats.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _selectedFilter == "Belum Dibaca" 
                              ? "Tidak ada pesan yang belum dibaca"
                              : "Belum ada percakapan",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];
                      return _buildChatListItem(chat, index, theme);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title, ThemeData theme) {
    final isSelected = _selectedFilter == title;
    final unreadCount = chats.where((chat) => chat["unread"] == true).length;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected 
                ? theme.colorScheme.primary
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected 
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withOpacity(0.3),
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected 
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              if (title == "Belum Dibaca" && unreadCount > 0) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: TextStyle(
                      color: isSelected ? theme.colorScheme.primary : Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatListItem(Map<String, dynamic> chat, int index, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chat["unread"] 
            ? theme.colorScheme.primary.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(chat["avatar"]),
              onBackgroundImageError: (exception, stackTrace) {},
              child: chat["avatar"].isEmpty 
                  ? const Icon(Icons.store, size: 24) 
                  : null,
            ),
            // Online indicator
            if (chat["isOnline"] == true)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.scaffoldBackgroundColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          chat["name"],
          style: TextStyle(
            fontWeight: chat["unread"] ? FontWeight.bold : FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            chat["message"],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: chat["unread"] 
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(0.7),
              fontWeight: chat["unread"] ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat["time"],
              style: TextStyle(
                fontSize: 12,
                color: chat["unread"] 
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: chat["unread"] ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 6),
            // Enhanced unread indicator
            if (chat["unread"] && chat["unreadCount"] > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  chat["unreadCount"].toString(),
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else if (chat["unread"])
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
          ],
        ),
        onTap: () {
          // Mark as read when tapped
          _markAsRead(chats.indexOf(chat));
          
          // Navigate to detail chat with store info
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailChatPage(
                storeName: chat["name"],
                storeAvatar: chat["avatar"],
              ),
            ),
          );
        },
      ),
    );
  }
}
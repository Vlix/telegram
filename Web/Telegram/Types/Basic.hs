{-# LANGUAGE PatternGuards #-}

-- | This module contains objects which represent data of Telegram Bot API responses
module Web.Telegram.Types.Basic where

import           Data.Text                  (Text (..))

import           Web.Telegram.Types.Static

-- | This object represents a Telegram user or bot.
data User = User
  { user_id         :: Int        -- ^ Unique identifier for this user or bot
  , user_first_name :: Text       -- ^ User‘s or bot’s first name
  , user_last_name  :: Maybe Text -- ^ User‘s or bot’s last name
  , user_username   :: Maybe Text -- ^ User‘s or bot’s username
  } deriving (Eq, Show)

-- | This object represents a chat.
data Chat =
  PrivateChat
  { chat_id         :: Int        -- ^ Unique identifier for this chat, not exceeding 1e13 by absolute value
  , chat_username   :: Maybe Text -- ^ Username, for private chats and channels if available
  , chat_first_name :: Text       -- ^ First name of the other party in a private chat
  , chat_last_name  :: Maybe Text -- ^ Last name of the other party in a private chat
  }
  | GroupChat
  { chat_id         :: Int        -- ^ Unique identifier for this chat, not exceeding 1e13 by absolute value
  , chat_title      :: Text       -- ^ Title, for channels and group chats
  }
  | SuperGroupChat
  { chat_id         :: Int        -- ^ Unique identifier for this chat, not exceeding 1e13 by absolute value
  , chat_title      :: Text       -- ^ Title, for channels and group chats
  , chat_username   :: Maybe Text -- ^ Username, for private chats and channels if available
  }
  | ChannelChat
  { chat_id         :: Int        -- ^ Unique identifier for this chat, not exceeding 1e13 by absolute value
  , chat_title      :: Text       -- ^ Title, for channels and group chats
  , chat_username   :: Maybe Text -- ^ Username, for private chats and channels if available
  } deriving (Eq, Show)

-- | This object represents a message.
data Message =
  ForwardedMessage
  { forward_message   :: Message    -- ^ The message that was forwarded, with the info user who forwarded it when and in which chat
  , forward_from      :: Maybe User -- ^ For forwarded messages, sender of the original message
  , forward_from_chat :: Maybe Chat -- ^ For forwarded messages, sender of the original message
  , forward_date      :: Int        -- ^ For forwarded messages, date the original message was sent in Unix time
  }
  | TextMessage
  { message_id        :: Int             -- ^ Unique message identifier
  , from              :: User            -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int             -- ^ Date the message was sent in Unix time
  , chat              :: Chat            -- ^ Conversation the message belongs to
  , text              :: Text            -- ^ For text messages, the actual UTF-8 text of the message
  , edit_date         :: Maybe Int       -- ^ Date the message was last edited in Unix time
  , reply_to_message  :: Maybe Message   -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  , entities          :: [MessageEntity] -- ^ For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  }
  | AudioMessage
  { message_id        :: Int             -- ^ Unique message identifier
  , from              :: User            -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int             -- ^ Date the message was sent in Unix time
  , chat              :: Chat            -- ^ Conversation the message belongs to
  , audio             :: Audio           -- ^ Message is an audio file, information about the file
  , caption           :: Maybe Text      -- ^ Caption for the photo or video
  , edit_date         :: Maybe Int       -- ^ Date the message was last edited in Unix time
  , reply_to_message  :: Maybe Message   -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  , entities          :: [MessageEntity] -- ^ For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  }
  | DocumentMessage
  { message_id        :: Int             -- ^ Unique message identifier
  , from              :: User            -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int             -- ^ Date the message was sent in Unix time
  , chat              :: Chat            -- ^ Conversation the message belongs to
  , document          :: Document        -- ^ Message is a general file, information about the file
  , caption           :: Maybe Text      -- ^ Caption for the photo or video
  , edit_date         :: Maybe Int       -- ^ Date the message was last edited in Unix time
  , reply_to_message  :: Maybe Message   -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  , entities          :: [MessageEntity] -- ^ For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  }
  | PhotoMessage
  { message_id        :: Int             -- ^ Unique message identifier
  , from              :: User            -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int             -- ^ Date the message was sent in Unix time
  , chat              :: Chat            -- ^ Conversation the message belongs to
  , photo             :: [PhotoSize]     -- ^ Message is a photo, available sizes of the photo
  , caption           :: Maybe Text      -- ^ Caption for the photo or video
  , edit_date         :: Maybe Int       -- ^ Date the message was last edited in Unix time
  , reply_to_message  :: Maybe Message   -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  , entities          :: [MessageEntity] -- ^ For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  }
  | StickerMessage
  { message_id        :: Int           -- ^ Unique message identifier
  , from              :: User          -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int           -- ^ Date the message was sent in Unix time
  , chat              :: Chat          -- ^ Conversation the message belongs to
  , sticker           :: Sticker       -- ^ Message is a sticker, information about the sticker
  , reply_to_message  :: Maybe Message -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  }
  | VideoMessage
  { message_id        :: Int             -- ^ Unique message identifier
  , from              :: User            -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int             -- ^ Date the message was sent in Unix time
  , chat              :: Chat            -- ^ Conversation the message belongs to
  , video             :: Video           -- ^ Message is a video, information about the video
  , caption           :: Maybe Text      -- ^ Caption for the photo or video
  , edit_date         :: Maybe Int       -- ^ Date the message was last edited in Unix time
  , reply_to_message  :: Maybe Message   -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  , entities          :: [MessageEntity] -- ^ For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  }
  | VoiceMessage
  { message_id        :: Int             -- ^ Unique message identifier
  , from              :: User            -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int             -- ^ Date the message was sent in Unix time
  , chat              :: Chat            -- ^ Conversation the message belongs to
  , voice             :: Voice           -- ^ Message is a voice message, information about the file
  , caption           :: Maybe Text      -- ^ Caption for the photo or video
  , edit_date         :: Maybe Int       -- ^ Date the message was last edited in Unix time
  , reply_to_message  :: Maybe Message   -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  , entities          :: [MessageEntity] -- ^ For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
  }
  | ContactMessage
  { message_id        :: Int           -- ^ Unique message identifier
  , from              :: User          -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int           -- ^ Date the message was sent in Unix time
  , chat              :: Chat          -- ^ Conversation the message belongs to
  , contact           :: Contact       -- ^ Message is a shared contact, information about the contact
  , reply_to_message  :: Maybe Message -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  }
  | LocationMessage
  { message_id        :: Int           -- ^ Unique message identifier
  , from              :: User          -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int           -- ^ Date the message was sent in Unix time
  , chat              :: Chat          -- ^ Conversation the message belongs to
  , location          :: Location      -- ^ Message is a shared location, information about the location
  , reply_to_message  :: Maybe Message -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  }
  | VenueMessage
  { message_id        :: Int           -- ^ Unique message identifier
  , from              :: User          -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int           -- ^ Date the message was sent in Unix time
  , chat              :: Chat          -- ^ Conversation the message belongs to
  , venue             :: Venue         -- ^ Message is a shared location, information about the location
  , reply_to_message  :: Maybe Message -- ^ For replies, the original message. Note that the 'Message' object in this field will not contain further 'reply_to_message' fields even if it itself is a reply.
  }
  | NewChatParticipantMessage
  { message_id      :: Int  -- ^ Unique message identifier
  , from            :: User -- ^ Sender, can be empty for messages sent to channels
  , date            :: Int  -- ^ Date the message was sent in Unix time
  , chat            :: Chat -- ^ Conversation the message belongs to
  , new_chat_member :: User -- ^ A new member was added to the group, information about them (this member may be the bot itself)
  }
  | LeftChatParticipantMessage
  { message_id       :: Int  -- ^ Unique message identifier
  , from             :: User -- ^ Sender, can be empty for messages sent to channels
  , date             :: Int  -- ^ Date the message was sent in Unix time
  , chat             :: Chat -- ^ Conversation the message belongs to
  , left_chat_member :: User -- ^ A member was removed from the group, information about them (this member may be the bot itself)
  }
  | NewChatTitleMessage
  { message_id     :: Int  -- ^ Unique message identifier
  , from           :: User -- ^ Sender, can be empty for messages sent to channels
  , date           :: Int  -- ^ Date the message was sent in Unix time
  , chat           :: Chat -- ^ Conversation the message belongs to
  , new_chat_title :: Text -- ^ A chat title was changed to this value
  }
  | NewChatPhotoMessage
  { message_id     :: Int         -- ^ Unique message identifier
  , from           :: User        -- ^ Sender, can be empty for messages sent to channels
  , date           :: Int         -- ^ Date the message was sent in Unix time
  , chat           :: Chat        -- ^ Conversation the message belongs to
  , new_chat_photo :: [PhotoSize] -- ^ A chat photo was change to this value
  }
  | DeleteChatPhotoMessage
  { message_id        :: Int  -- ^ Unique message identifier
  , from              :: User -- ^ Sender, can be empty for messages sent to channels
  , date              :: Int  -- ^ Date the message was sent in Unix time
  , chat              :: Chat -- ^ Conversation the message belongs to
  --, delete_chat_photo :: Bool -- ^ Service message: the chat photo was deleted
  }
  | 
  GroupChatCreatedMessage
  { message_id         :: Int  -- ^ Unique message identifier
  , from               :: User -- ^ Sender, can be empty for messages sent to channels
  , date               :: Int  -- ^ Date the message was sent in Unix time
  , chat               :: Chat -- ^ Conversation the message belongs to
  --, group_chat_created :: Bool            -- ^ Service message: the group has been created
  }
  | SuperGroupChatCreatedMessage
  { message_id         :: Int  -- ^ Unique message identifier
  , from               :: User -- ^ Sender, can be empty for messages sent to channels
  , date               :: Int  -- ^ Date the message was sent in Unix time
  , chat               :: Chat -- ^ Conversation the message belongs to
  --, supergroup_chat_created :: Bool            -- ^ Service message: the supergroup has been created
  }
  | ChannelChatCreatedMessage
  { message_id         :: Int  -- ^ Unique message identifier
  , from               :: User -- ^ Sender, can be empty for messages sent to channels
  , date               :: Int  -- ^ Date the message was sent in Unix time
  , chat               :: Chat -- ^ Conversation the message belongs to
  --, channel_chat_created    :: Bool            -- ^ Service message: the channel has been created
  }
  | MigratedToChatMessage
  { message_id         :: Int  -- ^ Unique message identifier
  , from               :: User -- ^ Sender, can be empty for messages sent to channels
  , date               :: Int  -- ^ Date the message was sent in Unix time
  , chat               :: Chat -- ^ Conversation the message belongs to
  , migrate_to_chat_id :: Int  -- ^ The group has been migrated to a supergroup with the specified identifier, not exceeding 1e13 by absolute value
  }
  | MigrateFromChatMessage
  { message_id           :: Int  -- ^ Unique message identifier
  , from                 :: User -- ^ Sender, can be empty for messages sent to channels
  , date                 :: Int  -- ^ Date the message was sent in Unix time
  , chat                 :: Chat -- ^ Conversation the message belongs to
  , migrate_from_chat_id :: Int  -- ^ The supergroup has been migrated from a group with the specified identifier, not exceeding 1e13 by absolute value
  }
  | PinnedMessage
  { message_id     :: Int     -- ^ Unique message identifier
  , from           :: User    -- ^ Sender, can be empty for messages sent to channels
  , date           :: Int     -- ^ Date the message was sent in Unix time
  , chat           :: Chat    -- ^ Conversation the message belongs to
  , pinned_message :: Message -- ^ Specified message was pinned.
  } deriving (Eq, Show)

data MessageEntity =
  MentionEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | HashtagEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | BotCommandEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | UrlEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | EmailEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | BoldEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | ItalicEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | CodeEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | PreEntity
  { entity_offset :: Int
  , entity_length :: Int
  }
  | TextLinkEntity
  { entity_offset :: Int
  , entity_length :: Int
  , entity_url    :: Text
  }
  | TextMentionEntity
  { entity_offset :: Int
  , entity_length :: Int
  , entity_user   :: User
  } deriving (Eq, Show)
  
-- | This object represents one size of a photo or a 'File' / 'Sticker' thumbnail.
data PhotoSize = PhotoSize
  { photo_file_id   :: Text       -- ^ Unique identifier for this file
  , photo_width     :: Int        -- ^ Photo width
  , photo_height    :: Int        -- ^ Photo height
  , photo_file_size :: Maybe Int  -- ^ File size
  } deriving (Eq, Show)

-- | This object represents an audio file to be treated as music by the Telegram clients.
data Audio = Audio
  { audio_file_id   :: Text       -- ^ Unique identifier for this file
  , audio_duration  :: Int        -- ^ Duration of the audio in seconds as defined by sender
  , audio_performer :: Maybe Text -- ^ Performer of the audio as defined by sender or by audio tags
  , audio_title     :: Maybe Text -- ^ Title of the audio as defined by sender or by audio tags
  , audio_mime_type :: Maybe Text -- ^ MIME type of the file as defined by sender
  , audio_file_size :: Maybe Int  -- ^ File size
  } deriving (Eq, Show)

-- | This object represents a general file (as opposed to 'PhotoSize', 'Voice' messages and 'Audio' files).
data Document = Document
  { doc_file_id   :: Text             -- ^ Unique file identifier
  , doc_thumb     :: Maybe PhotoSize  -- ^ Document thumbnail as defined by sender
  , doc_file_name :: Maybe Text       -- ^ Original filename as defined by sender
  , doc_mime_type :: Maybe Text       -- ^ MIME type of the file as defined by sender
  , doc_file_size :: Maybe Int        -- ^ File size
  } deriving (Eq, Show)

-- | This object represents a sticker.
data Sticker = Sticker
  { sticker_file_id   :: Text             -- ^ Unique identifier for this file
  , sticker_width     :: Int              -- ^ Sticker width
  , sticker_height    :: Int              -- ^ Sticker height
  , sticker_thumb     :: Maybe PhotoSize  -- ^ Sticker thumbnail in .webp or .jpg format
  , sticker_emoji     :: Maybe Text       -- ^ Emoji associated with the sticker
  , sticker_file_size :: Maybe Int        -- ^ File size
  } deriving (Eq, Show)

-- | This object represents a video file.
data Video = Video
  { video_file_id   :: Text             -- ^ Unique identifier for this file
  , video_width     :: Int              -- ^ Video width as defined by sender
  , video_height    :: Int              -- ^ Video height as defined by sender
  , video_duration  :: Int              -- ^ Duration of the video in seconds as defined by sender
  , video_thumb     :: Maybe PhotoSize  -- ^ Video thumbnail
  , video_mime_type :: Maybe Text       -- ^ MIME type of a file as defined by sender
  , video_file_size :: Maybe Int        -- ^ File size
  } deriving (Eq, Show)

-- | This object represents a voice note.
data Voice = Voice
  { voice_file_id   :: Text       -- ^ Unique identifier for this file
  , voice_duration  :: Int        -- ^ Duration of the audio in seconds as defined by sender
  , voice_mime_type :: Maybe Text -- ^ MIME type of the file as defined by sender
  , voice_file_size :: Maybe Int  -- ^ File size
  } deriving (Eq, Show)

-- | This object represents a phone contact.
data Contact = Contact
  { contact_phone_number :: Text       -- ^ Contact's phone number
  , contact_first_name   :: Text       -- ^ Contact's first name
  , contact_last_name    :: Maybe Text -- ^ Contact's last name
  , contact_user_id      :: Maybe Int  -- ^ Contact's user identifier in Telegram
  } deriving (Eq, Show)

-- | This object represents a point on the map.
data Location = Location
  { longitude :: Double -- ^ Longitude as defined by sender
  , latitude  :: Double -- ^ Latitude as defined by sender
  } deriving (Eq, Show)

-- | This object represents a venue.
data Venue = Venue
  { venue_location      :: Location   -- ^ Venue location
  , venue_title         :: Text       -- ^ Name of the venue
  , venue_address       :: Text       -- ^ Address of the venue
  , venue_foursquare_id :: Maybe Text -- ^ Foursquare identifier of the venue
  } deriving (Eq, Show)

-- | This object represent a user's profile pictures.
data UserProfilePhotos = UserProfilePhotos
  { total_count :: Int           -- ^ Total number of profile pictures the target user has
  , photos      :: [[PhotoSize]] -- ^ Requested profile pictures (in up to 4 sizes each)
  } deriving (Eq, Show)

-- | This object represents a file ready to be downloaded. The file can be downloaded via the link
--   @https://api.telegram.org/file/bot<token>/<file_path>@. It is guaranteed that the link will be valid
--   for at least 1 hour. When the link expires, a new one can be requested by calling 'getFile'.
--
--       Maximum file size to download is 20 MB
data File = File
  { file_id   :: Text         -- ^ Unique identifier for this file
  , file_size :: Maybe Int  -- ^ File size, if known
  , file_path :: Maybe Text -- ^ File path. Use @https://api.telegram.org/file/bot<token>/<file_path>@ to get the file.
  } deriving (Eq, Show)

  -- | This object represents a custom keyboard with reply options
data ReplyKeyboard =
  ReplyKeyboardMarkup
  { reply_keyboard             :: [[KeyboardButton]] -- ^ Array of button rows, each represented by an Array of Strings
  , reply_resize_keyboard      :: Maybe Bool         -- ^ Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
  , reply_one_time_keyboard    :: Maybe Bool         -- ^ Requests clients to hide the keyboard as soon as it's been used. Defaults to false.
  , reply_selective            :: Maybe Bool         -- ^ Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.    Example: A user requests to change the bot‘s language, bot replies to the request with a keyboard to select the new language. Other users in the group don’t see the keyboard.
  }
  | InlineKeyboardMarkup
  { reply_inline_keyboard      :: [[InlineKeyboardButton]] } -- ^ Array of button rows, each represented by an Array of InlineKeyboardButton objects
  -- | Upon receiving a message with this object, Telegram clients will hide the current custom keyboard and display the default letter-keyboard. By default, custom keyboards are displayed until a new keyboard is sent by a bot. An exception is made for one-time keyboards that are hidden immediately after the user presses a button
  | ReplyKeyboardHide
  { reply_selective            :: Maybe Bool -- ^ Use this parameter if you want to hide keyboard for specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.    Example: A user votes in a poll, bot returns confirmation message in reply to the vote and hides keyboard for that user, while still showing the keyboard with poll options to users who haven't voted yet.
  }
  -- | Upon receiving a message with this object, Telegram clients will display a reply interface to the user (act as if the user has selected the bot‘s message and tapped ’Reply'). This can be extremely useful if you want to create user-friendly step-by-step interfaces without having to sacrifice privacy mode.
  | ForceReply
  { reply_selective            :: Maybe Bool -- ^ Use this parameter if you want to force reply from specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
  } deriving (Eq, Show)

-- |  This object represents one button of the reply keyboard. For simple text buttons String can be used instead of this object to specify text of the button.
data KeyboardButton =
  TextButton
  { button_text :: Text }
  | ContactButton
  { button_text :: Text }
  | LocationButton
  { button_text :: Text }
  deriving (Eq, Show)

-- | This object represents one button of an inline keyboard.
data InlineKeyboardButton =
  InlineUrlButton
  { inline_keyboard_text :: Text
  , inline_keyboard_url  :: Text
  }
  | InlineCallbackButton
  { inline_keyboard_text          :: Text
  , inline_keyboard_callback_data :: Text
  }
  | InlineSwitchButton
  { inline_keyboard_text                :: Text
  , inline_keyboard_switch_inline_query :: Text
  } deriving (Eq, Show)

-- | This object represents an incoming callback query from a callback button in an inline keyboard.
data CallbackQuery =
  CallbackMessage
  { callback_query_id                :: Text
  , callback_query_from              :: User
  , callback_query_message           :: Message
  , callback_query_data              :: Text
  }
  | CallbackInline
  { callback_query_id                :: Text
  , callback_query_from              :: User
  , callback_query_inline_message_id :: Text
  , callback_query_data              :: Text
  } deriving (Eq, Show)

-- | This object contains information about one member of the chat.
data ChatMember =
  ChatMember
  { chatmember_user   :: User
  , chatmember_status :: ChatMemberStatus
  } deriving (Eq, Show)
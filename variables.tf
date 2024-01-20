variable "dynamodb_attributes" {
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "title"
      type = "S"
    },
    {
      name = "published_at"
      type = "S"
    }
  ]
}
